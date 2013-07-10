package  
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

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
		this.tiledMap.addEventListener(MouseEvent.CLICK , clickHandler);
		this.addChild(this.tiledMap);
		
		this.addEventListener(Event.ENTER_FRAME, loop);
	}
	
	private function loop(event:Event):void 
	{
		//this.tiledMap.update();
	}
	
	private function clickHandler(event:MouseEvent):void 
	{
		this.globalPos.x = event.stageX;
		this.globalPos.y = event.stageY;
		this.localPos = this.globalToLocal(this.globalPos);
		var node:NodeVo = this.tiledMap.getNodeByPostion(this.localPos.x, this.localPos.y);
		trace(node.row, node.column);
		trace("上行",node.upRow, "下行",  node.downRow);
		trace("左列", node.leftColumn, "右列",  node.rightColumn);
	}
	
}
}