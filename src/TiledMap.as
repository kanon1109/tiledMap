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
		var node:NodeVo;
		var txt:TextField;
		for (var i:int = 0; i < 5; i++) 
		{
			for (var j:int = 0; j < 5; j++) 
			{
				node = new NodeVo();
				node.backBg = new Image();
				node.backBg.mouseEnabled = false;
				node.backBg.mouseChildren = false;
				txt = node.backBg.getChildByName("posTxt") as TextField;
				txt.text = i + "_" + j;
				node.row = i;
				node.column = j;
				node.backBg.x = node.row * node.backBg.width;
				node.backBg.y = node.column * node.backBg.height;
				this.addChild(node.backBg);
				this.nodeList[i + "_" + j] = node;
			}
		}
		//和默认底板的高宽一致
		NodeVo.WIDTH = node.backBg.width;
		NodeVo.HEIGHT = node.backBg.height;
	}
	
	/**
	 * 根据 行列获取节点数据
	 * @param	row		行
	 * @param	column	列
	 * @return	节点数据
	 */
	public function getNode(row:int, column:int):NodeVo
	{
		return this.nodeList[row + "_" + column];
	}
	
	/**
	 * 根据坐标系获取节点
	 * @param	x	x坐标
	 * @param	y	y坐标
	 */
	public function getNodeByPostion(x:Number, y:Number):NodeVo
	{
		var row:int = Math.floor(x / NodeVo.WIDTH);
		var column:int = Math.floor(y / NodeVo.HEIGHT);
		return this.getNode(row, column);
	}
	
	/**
	 * 渲染
	 */
	public function render():void
	{
		
	}
}
}