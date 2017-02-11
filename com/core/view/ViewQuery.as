package com.core.view
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	public class ViewQuery
	{
		private var _view:DisplayObject;
		private var _container:*;
		private var _arr:Array = new Array();
		public function ViewQuery(views:*) {
			if(views is DisplayObject) {
				this._view = views;
				this._arr = [this._view];
			}else if(views is Array) {
				this._arr = views;
				this._view = this._arr[0];
			}
		}
		
		public function container(val:*):ViewQuery {
			this._container = val;
			return this;
		}
		
		public function key(k:String):ViewQuery {
			this._view = this.viewVal(k);
			this._arr = [this._view];
			return this;
		}
		
		public function spriteVal(k:String = null):Sprite {
			return this.viewVal(k) as Sprite;
		}
		
		public function clipVal(k:String = null):MovieClip {
			return this.viewVal(k) as MovieClip;
		}
		
		public function textFieldVal(k:String = null):TextField {
			return this.viewVal(k) as TextField;
		}
		
		public function viewVal(k:String = null):DisplayObject {
			if(!k) {
				return this._view;
			}else {
				var container:DisplayObjectContainer = this._view as DisplayObjectContainer;
				if(container) {
					return container.getChildByName(k);
				}else {
					return null;
				}	
			}
		}
		
		public function arrayVal():Array {
			return this._arr;
		}
		
		public function move(dx:Number, dy:Number):ViewQuery {
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.move(dx, dy, obj);
			}
			return this;
		}
		
		public function pos(px:Number, py:Number, obj:DisplayObject, trans2LT:Boolean = false):ViewQuery {
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.pos(px, py, obj, trans2LT);
			}
			return this;
		}
		
		public function posX(px:Number, trans2LT:Boolean = false):ViewQuery {
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.posX(px, obj, trans2LT);
			}
			return this;
		}
		
		public function posY(py:Number, obj:DisplayObject, trans2LT:Boolean = false):ViewQuery {
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.posY(py, obj, trans2LT);
			}
			return this;
		}
		
		public function left(delta:Number = 0, container:*=null, trans2LT:Boolean = false):ViewQuery {
			if(!container) container = this._container;
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.left(obj, delta, container, trans2LT);
			}
			return this;
		}
		
		public function right(delta:Number = 0, container:*=null, trans2LT:Boolean = false):ViewQuery {
			if(!container) container = this._container;
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.right(obj, delta, container, trans2LT);
			}
			return this;
		}
		
		public function center(delta:Number = 0, container:*=null, trans2LT:Boolean = false):ViewQuery {
			if(!container) container = this._container;
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.center(obj, delta, container, trans2LT);
			}
			return this;
		}
		
		public function top(delta:Number = 0, container:*=null, trans2LT:Boolean = false):ViewQuery {
			if(!container) container = this._container;
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.top(obj, delta, container, trans2LT);
			}
			return this;
		}
		
		public function bottom(delta:Number = 0, container:*=null, trans2LT:Boolean = false):ViewQuery {
			if(!container) container = this._container;
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.bottom(obj, delta, container, trans2LT);
			}
			return this;
		}
		
		public function middle(delta:Number = 0, container:*=null, trans2LT:Boolean = false):ViewQuery {
			if(!container) container = this._container;
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.middle(obj, delta, container, trans2LT);
			}
			return this;
		}
		
		public function anchor(rx:Number, ry:Number, trans2LT:Boolean = false):ViewQuery {
			for each(var obj:DisplayObject in this._arr) {
				Mlayout.anchor(rx, ry, obj, trans2LT);
			}
			return this;
		}
		
		public function spaceHorazontal(begin:Number, end:Number, trans2LT:Boolean = true):ViewQuery {			
			Mlayout.spaceHorazontal(begin, end, this._arr, trans2LT);
			return this;
		}
		
		public function spaceVertical(begin:Number, end:Number, trans2LT:Boolean = true):ViewQuery {
			Mlayout.spaceVertical(begin, end, this._arr, trans2LT);
			return this;
		}
	}
}