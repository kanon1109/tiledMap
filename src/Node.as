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
	public var outSide:Rectangle;
	/*整个地图的高宽范围*/
	public var inSide:Rectangle;
	public function Node(inSide:Rectangle, outSide:Rectangle)
	{
		this.inSide = inSide;
		this.outSide = outSide;
	}
	
	/**
	 * 更新
	 */
	public function update():void
	{
		if (Math.abs(this.vx) < .1) this.vx = 0;
		if (Math.abs(this.vy) < .1) this.vy = 0;
		
		this.nextX = this.x + this.vx;
		this.nextY = this.y + this.vy;
		
		if (this.nextX + this.backBg.width < this.outSide.left  && this.vx < 0) this.nextX += this.inSide.width;
		if (this.nextX > this.outSide.right && this.vx > 0) this.nextX -= this.inSide.width;
		
		if (this.nextY + this.backBg.height < this.outSide.top && this.vy < 0) this.nextY += this.inSide.height;
		if (this.nextY > this.outSide.bottom && this.vy > 0) this.nextY -= this.inSide.height;
		
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