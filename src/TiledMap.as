package  
{
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Rectangle;
/**
 * ...地图格子
 * @author Kanon
 */
public class TiledMap extends Sprite 
{
	//显示范围
	private var viewPort:Rectangle;
	/**
	 * 地图格子类
	 * @param	viewPort	显示范围
	 */
	public function TiledMap(stage:Stage, viewPort:Rectangle = null) 
	{
		if (viewPort == null) viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		this.viewPort = viewPort;
		this.init();
	}
	
	/**
	 * 初始化
	 */
	private function init():void
	{
		var node:NodeVo;
		for (var i:int = 0; i < 10; i++) 
		{
			for (var j:int = 0; j < 10; j++) 
			{
				node = new NodeVo();
				node.backBg = new Image();
				node.gapH = 100;
				node.gapV = 80;
				node.row = i;
				node.column = j;
				node.backBg.x = node.row * node.backBg.width;
				node.backBg.y = node.column * node.backBg.height;
				this.addChild(node.backBg);
			}
		}
	}
	
	/**
	 * 渲染
	 */
	public function render():void
	{
		
	}
}
}