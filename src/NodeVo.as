package  
{
import flash.display.Sprite;
/**
 * ...单个地图节点
 * @author Kanon
 */
public class NodeVo 
{
	/*节点编号*/
	public var no:int;
	/*底板层*/
	public var backBg:Sprite;
	/*行数*/
	public var row:int;
	/*列数*/
	public var column:int;
	/*节点宽*/ 
	public static var WIDTH:Number = 0;
	/*节点高*/
	public static var HEIGHT:Number = 0;
	/*x坐标*/
	protected var _x:Number = 0;
	/*y坐标*/
	protected var _y:Number = 0;
	/*上行*/
	public var upRow:int = -1;
	/*下行*/
	public var downRow:int = -1;
	/*左列*/
	public var leftColumn:int = -1;
	/*右列*/
	public var rightColumn:int = -1;
	
	/**
	 * 移动
	 * @param	x
	 * @param	y
	 */
	public function move(x:Number, y:Number):void
	{
		this._x = x;
		this._y = y;
		this.backBg.x = x;
		this.backBg.y = y;
	}
	
	/**
	 * x坐标
	 */
	public function get x():Number{ return _x; }
	public function set x(value:Number):void 
	{
		_x = value;
		this.backBg.x = _x;
	}
	
	/**
	 * y坐标
	 */
	public function get y():Number{ return _y; }
	public function set y(value:Number):void 
	{
		_y = value;
		this.backBg.y = _y;
	}
	
	/**
	 * 销毁自己
	 */
	public function removeFromParent():void
	{
		if (this.backBg && 
			this.backBg.parent)
			this.backBg.parent.removeChild(this.backBg);
	}
	
	/**
	 * 销毁
	 */
	public function destroy():void
	{
		
	}
}
}