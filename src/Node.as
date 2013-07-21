package  
{
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Rectangle;
import flash.net.URLRequest;
/**
 * ...单个地图节点
 * @author Kanon
 */
public class Node 
{
	/*底板层*/
	public var backBg:Sprite;
	/*地图容器*/
	public var imageContainer:Sprite;
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
	/*移动范围*/
	public var outSide:Rectangle;
	/*整个地图的高宽范围*/
	public var inSide:Rectangle;
	//加载器
	private var loader:Loader;
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
		
		if (this.nextX + this.backBg.width < this.outSide.left && this.vx < 0)
		{
			this.nextX += this.inSide.width;
			this.column--;
		}
		
		if (this.nextX > this.outSide.right && this.vx > 0)
		{
			this.nextX -= this.inSide.width;
			this.column++;
		}
		
		if (this.nextY + this.backBg.height < this.outSide.top && this.vy < 0) 
		{
			this.nextY += this.inSide.height;
			this.row--;
		}
		
		if (this.nextY > this.outSide.bottom && this.vy > 0)
		{
			this.nextY -= this.inSide.height;
			this.row++;
		}
		
		this.backBg.x = this.x = this.nextX;
		this.backBg.y = this.y = this.nextY;
	}
	
	/**
	 * 重载
	 */
	private function load(url:String):void
	{
		if (!this.loader)
		{
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		this.imageContainer.addChild(this.loader);
		this.loader.load( new URLRequest(url))
	}
	
	private function errorHandler(event:IOErrorEvent):void 
	{
		
	}
	
	private function loadComplete(event:Event):void 
	{
		
	}
	
	/**
	 * 销毁自己
	 */
	public function removeFromParent():void
	{
		if (this.backBg && 
			this.backBg.parent)
			this.backBg.parent.removeChild(this.backBg);
		
		if (this.imageContainer && 
			this.imageContainer.parent)
			this.imageContainer.parent.removeChild(this.imageContainer);
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