package  
{
import flash.display.Sprite;

/**
 * ...测试类
 * @author Kanon
 */
public class Test extends Sprite 
{
	public function Test() 
	{
		var tiledMap:TiledMap = new TiledMap(stage);
		this.addChild(tiledMap);
	}
	
}
}