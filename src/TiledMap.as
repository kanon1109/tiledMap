package  
{
import flash.display.Sprite;
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
	public function TiledMap(viewPort:Rectangle = null) 
	{
		if (!viewPort) viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		this.viewPort = viewPort;
	}
	
	/**
	 * 渲染
	 */
	public function render():void
	{
		
	}
}
}