package  
{
import flash.display.Sprite;
import flash.display.Stage;
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
	//结点的边界
	private var side:Rectangle;
	/**
	 * 地图格子类
	 */
	public function TiledMap(row:int, column:int, nodeWidth:int = 100, nodeHeight:int = 100) 
	{
		//行
		this.row = row;
		//列
		this.column = row;
		//结点列表
		this.nodeList = new Dictionary();
		//结点宽
		this.nodeWidth = nodeWidth;
		//结点高
		this.nodeHeight = nodeHeight;
		//边界
		this.side = new Rectangle(0, 0, this.column * this.nodeWidth, this.row * this.nodeHeight);
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
				node = new Node(this.side);
				node.backBg = new Image();
				node.x = node.nextX = node.backBg.width * j;
				node.y = node.nextY = node.backBg.height * i;
				//以列数为key存放 行数列表
				if (!this.nodeList[i]) this.nodeList[i] = [];
				this.nodeList[i].push(node);
				this.addChild(node.backBg);
			}
		}
		//和默认底板的高宽一致
		Node.WIDTH = node.backBg.width;
		Node.HEIGHT = node.backBg.height;
	}
	
	/**
	 * 更新节点数据
	 */
	public function update():void
	{
		var rowArr:Array;
		var node:Node;
		for each (rowArr in this.nodeList) 
		{
			var length:int = rowArr.length;
			for (var i:int = 0; i < length; i += 1) 
			{
				node = rowArr[i];
				node.update();
				this.drag(node);
			}
		}
		if (this.isDrag)
		{
			this.prevMouseX = this.mouseX;
			this.prevMouseY = this.mouseY;
		}
	}
	
	/**
	 * 拖动
	 * @param	node	当前节点
	 */
	private function drag(node:Node):void
	{
		if (this.isDrag)
		{
			node.vx = this.mouseX - this.prevMouseX;
			node.vy = this.mouseY - this.prevMouseY;
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
	 * 根据 行列获取节点数据
	 * @param	column	列
	 * @param	row		行
	 * @return	节点数据
	 */
	public function getNode(column:int, row:int):Node
	{
		return this.nodeList[column + "_" + row];
	}
	
	/**
	 * 根据坐标系获取节点
	 * @param	x	x坐标
	 * @param	y	y坐标
	 */
	public function getNodeByPostion(x:Number, y:Number):Node
	{
		var row:int = Math.floor(y / Node.HEIGHT);
		var column:int = Math.floor(x / Node.WIDTH);
		return this.getNode(column, row);
	}
}
}