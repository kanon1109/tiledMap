package  
{
import flash.display.Sprite;
import flash.geom.Rectangle;
/**
 * ...单个地图节点
 * @author Kanon
 */
public class Node 
{
	/*底板层*/
	public var backBg:Sprite;
	/*节点宽*/ 
	public static var WIDTH:Number = 0;
	/*节点高*/
	public static var HEIGHT:Number = 0;
	/*x坐标*/
	public var x:Number = 0;
	/*y坐标*/
	public var y:Number = 0;
	/*下一个x坐标位置*/
	public var nextX:Number = 0;
	/*下一个y坐标位置*/
	public var nextY:Number = 0;
	/*横向速度*/
	public var vx:Number = 0;
	/*纵向速度*/
	public var vy:Number = 0;
	/*移动范围*/
	public var side:Rectangle;
	public function Node(side)
	{
		this.side = side;
	}
	
	/**
	 * 更新
	 */
	public function update():void
	{
		if (Math.abs(this.vx) < .3) this.vx = 0;
		if (Math.abs(this.vy) < .3) this.vy = 0;
		
		this.nextX = this.x + this.vx;
		this.nextY = this.y + this.vy;
		
		if (this.nextX + this.backBg.width < this.side.left  && this.vx < 0) this.nextX += this.side.width;
		if (this.nextX > this.side.right && this.vx > 0) this.nextX -= this.side.width;
		
		if (this.nextY + this.backBg.height < this.side.top && this.vy < 0) this.nextY += this.side.top;
		if (this.nextY > this.side.bottom && this.vy > 0) this.nextY -= this.side.bottom;
		
		this.backBg.x = this.x = this.nextX;
		this.backBg.y = this.y = this.nextY;
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
		this.removeFromParent();
		this.backBg = null;
	}
}
}