package com.core.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * 基本View，可以设置skin和通过query对skin进行查找和修改
	 * */
	public class ViewBase extends Sprite
	{
		private var _skin:Sprite;
		
		public function get skin():Sprite {
			return this._skin;
		}
		
		public function set skin(val:Sprite):void {
			if(this._skin) {
				this.removeChild(this._skin);
			}
			this._skin = val;
			this.addChildAt(this._skin, 0);
		}
		
		public function query():ViewQuery {
			return new ViewQuery(this._skin);
		}
	}
}