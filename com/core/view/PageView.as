package com.core.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 基本游戏页面
	 * */
	public class PageView extends ViewBase
	{	
		public function start(args:Object = null):void {
			Mview.content.addChild(this);
		}
		
		public function end(args:Object = null):void {
			Mview.content.removeChild(this);
		}
	}
}