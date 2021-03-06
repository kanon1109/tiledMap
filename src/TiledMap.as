package  
{
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.utils.Dictionary;
/**
 * ...地图格子
 * @author Kanon
 */
public class TiledMap extends Sprite 
{
	//节点字典
	private var nodeList:Dictionary;
	//当前最大行数
	private var row:int;
	//当前最大列数
	private var column:int;
	//是否在拖动状态
	private var isDrag:Boolean;
	//上一次鼠标x位置
	private var prevMouseX:Number;
	//上一次鼠标y位置
	private var prevMouseY:Number;
	//结点宽
	private var nodeWidth:Number;
	//结点高
	private var nodeHeight:Number;
	//内边界
	private var inSide:Rectangle;
	//外的边界
	private var outSide:Rectangle;
	//内外边界整合后的可视边界
	private var side:Rectangle;
	//格子的起始x坐标位置
	private var startX:Number;
	//格子的起始y坐标位置
	private var startY:Number;
	/*摩擦力*/
	private var _friction:Number = .9;
	/**
	 * 地图格子类
	 * @param	startX		x坐标起始位置
	 * @param	startY		y坐标起始位置
	 * @param	row			行数
	 * @param	column		列数
	 * @param	nodeWidth	节点宽度
	 * @param	nodeHeight	节点高度
	 * @param	outSide		外部范围 默认为空，如果设置为空则根据节点 行数×节点高度，列数×节点宽度为范围高宽。
	 */
	public function TiledMap(startX:Number, startY:Number, 
							 row:int, column:int, 
							 nodeWidth:int = 100, nodeHeight:int = 100, 
							 outSide = null)
	{
		//行
		this.row = row;
		//列
		this.column = column;
		//结点列表
		this.nodeList = new Dictionary();
		//结点宽
		this.nodeWidth = nodeWidth;
		//结点高
		this.nodeHeight = nodeHeight;
		//格子的起始x坐标位置
		this.startX = startX;
		//格子的起始y坐标位置
		this.startY = startY;
		//内边界
		this.inSide = new Rectangle(this.startX, this.startY, 
									this.column * this.nodeWidth, 
									this.row * this.nodeHeight);
		//外边界
		this.outSide = outSide;
		if (!outSide) this.outSide = this.inSide;
		//初始化结点
		this.initNode();
	}
	
	/**
	 * 初始化结点
	 */
	private function initNode():void 
	{
		var node:Node;
		var txt:TextField;
		//行数
		for (var i:int = 0; i < this.row; i += 1)
		{
			//列数
			for (var j:int = 0; j < this.column; j += 1) 
			{
				node = new Node(this.inSide, this.outSide);
				node.backBg = new Image();
				node.imageContainer = new Sprite();
				node.x = node.nextX = this.nodeWidth * j + this.startX;
				node.y = node.nextY = this.nodeHeight * i + this.startY;
				node.row = i;
				node.column = j;
				//以列数为key存放 行数列表
				if (!this.nodeList[i]) this.nodeList[i] = [];
				this.nodeList[i].push(node);
				this.addChild(node.backBg);
				this.addChild(node.imageContainer);
			}
		}
	}
	
	/**
	 * 更新节点数据
	 */
	public function update():void
	{
		var rowArr:Array;
		var node:Node;
		var length:int;
		for each (rowArr in this.nodeList) 
		{
			length = rowArr.length;
			for (var i:int = 0; i < length; i += 1) 
			{
				node = rowArr[i];
				node.vx *= this.friction;
				node.vy *= this.friction;
				if (this.isDrag)
				{
					node.vx = this.mouseX - this.prevMouseX;
					node.vy = this.mouseY - this.prevMouseY;
				}
				node.update();
			}
		}
		if (this.isDrag)
		{
			this.prevMouseX = this.mouseX;
			this.prevMouseY = this.mouseY;
		}
	}
	
	/**
	 * 拖拽
	 */
	public function startTiledDrag():void
	{
		this.isDrag = true;
		this.prevMouseX = this.mouseX;
		this.prevMouseY = this.mouseY;
	}
	
	/**
	 * 停止拖动
	 */
	public function stopTiledDrag():void
	{
		this.isDrag = false;
	}
	
	/**
	 * 拖动时的摩擦力
	 */
	public function get friction():Number{ return _friction; }
	public function set friction(value:Number):void 
	{
		_friction = value;
	}
}
}