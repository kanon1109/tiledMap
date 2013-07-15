package  
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import net.hires.debug.Stats;
/**
 * ...测试类
 * @author Kanon
 */
public class Test extends Sprite 
{
	private var tiledMap:TiledMap;
	private var localPos:Point;
	private var globalPos:Point;
	public function Test() 
	{
		this.localPos = new Point();
		this.globalPos = new Point();
		this.tiledMap = new TiledMap(stage);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN , mouseDownHandler);
		stage.addEventListener(MouseEvent.MOUSE_UP , mouseUpHandler);
		this.addChild(this.tiledMap);
		this.addEventListener(Event.ENTER_FRAME, loop);
		this.addChild(new Stats());
	}
	
	private function mouseUpHandler(event:MouseEvent):void 
	{
		this.tiledMap.stopTiledDrag();
	}
	
	private function mouseDownHandler(event:MouseEvent):void 
	{
		this.tiledMap.startTiledDrag();
	}
	
	private function loop(event:Event):void 
	{
		this.tiledMap.update();
	}
	
	private function clickHandler(event:MouseEvent):void 
	{
		this.globalPos.x = event.stageX;
		this.globalPos.y = event.stageY;
		this.localPos = this.globalToLocal(this.globalPos);
		var node:NodeVo = this.tiledMap.getNodeByPostion(this.localPos.x, this.localPos.y);
	}
	
}
}