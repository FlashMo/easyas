package com.core.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class GameStage extends Sprite
	{
		private var _stageRect:Rectangle = new Rectangle();
		private var _content:Sprite = new Sprite();
		
		public function GameStage() {
			this.addChild(this._content);
		}
		
		public function setSize(w:Number, h:Number):void {
			this._stageRect = new Rectangle(0, 0, w, h);
		}
		
		public function get stageRect():Rectangle {
			return this._stageRect;
		}
		
		public function get content():Sprite {
			return this._content;
		}
		
		public function drawBackground(color:uint):void {
			this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, this.stageRect.width, this.stageRect.height);
		}
	}
}