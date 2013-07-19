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
	//当前行数
	public var row:int;
	//当前列数
	public var column:int;
	//最大节点行数
	public var rowMax:int;
	//最大节点列数
	public var columnMax:int ;
	/*移动范围*/
	public var outSide:Rectangle;
	/*整个地图的高宽范围*/
	public var inSide:Rectangle;
	public function Node(inSide:Rectangle, outSide:Rectangle, 
						 rowMax:int, columnMax:int)
	{
		this.inSide = inSide;
		this.outSide = outSide;
		this.rowMax = rowMax;
		this.columnMax = columnMax;
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
		
		if (this.row <= 0 || this.row >= this.rowMax) this.vx = 0;
		if (this.column <= 0 || this.column >= this.columnMax) this.vy = 0;
		
		if (this.nextX + this.backBg.width < this.outSide.left && this.vx < 0) 
		{
			if (this.rowMax == -1 || this.row > 0)
			{
				this.nextX += this.inSide.width;
				this.row--;
			}
		}
		
		if (this.nextX > this.outSide.right && this.vx > 0)
		{
			if (this.rowMax == -1 || this.row < this.rowMax)
			{
				this.nextX -= this.inSide.width;
				this.row++;
			}
		}
		
		if (this.nextY + this.backBg.height < this.outSide.top && this.vy < 0) 
		{
			if (this.columnMax == -1 || this.column > 0)
			{
				this.nextY += this.inSide.height;
				this.column--;
			}
		}
		
		if (this.nextY > this.outSide.bottom && this.vy > 0)
		{
			if (this.columnMax == -1 || this.column < this.columnMax)
			{
				this.nextY -= this.inSide.height;
				this.column++;
			}
		}
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