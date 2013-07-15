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
	//显示范围
	private var viewPort:Rectangle;
	//当前最大行数
	private var rowMax:int;
	//当前最小行数
	private var rowMin:int;
	//当前最大列数
	private var columnMax:int;
	//当前最小列数
	private var columnMin:int;
	//是否在拖动状态
	private var isDrag:Boolean;
	//上一次鼠标位置
	private var prevMouseX:Number;
	private var prevMouseY:Number;
	/**
	 * 地图格子类
	 * @param	viewPort	显示范围
	 */
	public function TiledMap(stage:Stage, viewPort:Rectangle = null) 
	{
		if (!viewPort) viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		this.viewPort = viewPort;
		this.initData();
	}
	
	/**
	 * 初始化数据
	 */
	private function initData():void 
	{
		this.nodeList = new Dictionary();
		//行
		this.rowMin = 0;
		this.rowMax = 6;
		//列
		this.columnMin = 0;
		this.columnMax = 6;
		var node:NodeVo;
		var txt:TextField;
		for (var i:int = this.columnMin; i <= this.columnMax; i += 1)
		{
			//列
			for (var j:int = this.rowMin; j <= this.rowMax; j += 1)
			{
				//行
				node = new NodeVo();
				node.backBg = new Image();
				node.backBg.mouseEnabled = false;
				node.backBg.mouseChildren = false;
				txt = node.backBg.getChildByName("posTxt") as TextField;
				txt.text = j + "_" + i + "\n行= " + j + "\n列= " + i;
				node.row = j;
				node.column = i;
				
				//第一列
				if (i == this.columnMin)
					node.leftColumn = this.columnMax;
				//最后一列
				if (i == this.columnMax)
					node.rightColumn = this.columnMin;
				
				//第一行
				if (j == this.rowMin)
					node.upRow = this.rowMax;
				//最后一行
				if (j == this.rowMax)
					node.downRow = this.rowMin;
				
				//计算出上下左右的行列索引
				if (j > this.rowMin) node.upRow = j - 1;
				if (j < this.rowMax) node.downRow = j + 1;
				
				if (i > this.columnMin) node.leftColumn = i - 1;
				if (i < this.columnMax) node.rightColumn = i + 1;
				
				node.move(node.column * node.backBg.width, node.row * node.backBg.height);
				this.addChild(node.backBg);
				this.nodeList[i + "_" + j] = node;
			}
		}
		//和默认底板的高宽一致
		NodeVo.WIDTH = node.backBg.width;
		NodeVo.HEIGHT = node.backBg.height;
	}
	
	/**
	 * 更新节点数据
	 */
	public function update():void
	{
		var node:NodeVo;
		for each (node in this.nodeList) 
		{
			this.checkRange(node);
			this.drag(node);
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
	private function drag(node:NodeVo):void
	{
		if (this.isDrag)
		{
			node.x += this.mouseX - this.prevMouseX;
			node.y += this.mouseY - this.prevMouseY;
		}
	}
	
	/**
	 * 判断移动范围
	 * @param	node	当前节点
	 */
	private function checkRange(node:NodeVo):void
	{
		var lastNode:NodeVo;
		//相同行节点
		var sameRowNode:NodeVo;
		//相同行节点
		var sameColumnNode:NodeVo;
		var i:int;
		//左右越界判断
		if (node.x + NodeVo.WIDTH < this.viewPort.left)
		{
			lastNode = this.getNode(node.leftColumn, node.row);
			node.x = lastNode.x + NodeVo.WIDTH;
			for (i = this.rowMin; i <= this.rowMax; i += 1)
			{
				sameRowNode = this.getNode(node.column, i);
				sameRowNode.x = node.x;
			}
		}
		else if (node.x > this.viewPort.right)
		{
			lastNode = this.getNode(node.rightColumn, node.row);
			node.x = lastNode.x - NodeVo.WIDTH;
			for (i = this.rowMin; i <= this.rowMax; i += 1)
			{
				sameRowNode = this.getNode(node.column, i);
				sameRowNode.x = node.x;
			}
		}
		
		//上下越界判断
		if (node.y + NodeVo.HEIGHT < this.viewPort.top)
		{
			lastNode = this.getNode(node.column, node.upRow);
			node.y = lastNode.y + NodeVo.HEIGHT;
			for (i = this.columnMin; i <= this.columnMax; i += 1)
			{
				sameColumnNode = this.getNode(i, node.row);
				sameColumnNode.y = node.y;
			}
		}
		else if (node.y > this.viewPort.bottom)
		{
			lastNode = this.getNode(node.column, node.downRow);
			node.y = lastNode.y - NodeVo.HEIGHT;
			for (i = this.columnMin; i <= this.columnMax; i += 1)
			{
				sameColumnNode = this.getNode(i, node.row);
				sameColumnNode.y = node.y;
			}
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
	public function getNode(column:int, row:int):NodeVo
	{
		return this.nodeList[column + "_" + row];
	}
	
	/**
	 * 根据坐标系获取节点
	 * @param	x	x坐标
	 * @param	y	y坐标
	 */
	public function getNodeByPostion(x:Number, y:Number):NodeVo
	{
		var row:int = Math.floor(y / NodeVo.HEIGHT);
		var column:int = Math.floor(x / NodeVo.WIDTH);
		return this.getNode(column, row);
	}
}
}