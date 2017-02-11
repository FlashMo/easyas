package com.core.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class GamePage extends GameLayer
	{	
		public function start(args:Object = null):void {
			Mview.content.addChild(this);
		}
		
		public function end(args:Object = null):void {
			Mview.content.removeChild(this);
		}
	}
}