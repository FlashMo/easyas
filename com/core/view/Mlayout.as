package com.core.view
{
	import flash.display.DisplayObject;

	public class Mlayout
	{
		static public function move(dx:Number, dy:Number, obj:DisplayObject):DisplayObject {
			obj.x += dx;
			obj.y += dy;
			return obj;
		}
		
		static public function posX(px:Number, obj:DisplayObject, trans2LT:Boolean = false):DisplayObject {
			if(trans2LT) {
				px -= obj.getRect(obj).left;
			}
			obj.x = px;
			return obj;
		}
		
		static public function posY(py:Number, obj:DisplayObject, trans2LT:Boolean = false):DisplayObject {
			if(trans2LT) {
				py -= obj.getRect(obj).top;
			}
			obj.y = py;
			return obj;
		}
		
		static public function pos(px:Number, py:Number, obj:DisplayObject, trans2LT:Boolean = false):DisplayObject {
			posX(px, obj, trans2LT);
			posY(py, obj, trans2LT);
			return obj;
		}
		
		static public function left(obj:DisplayObject, delta:Number = 0, container:* = null, trans2LT:Boolean = false)
			:DisplayObject {
			if(!container) container = Mview.getStage().stageRect;
			posX(delta, obj, trans2LT);
			return obj;
		}
		
		static public function center(obj:DisplayObject, delta:Number = 0, container:* = null, trans2LT:Boolean = false)
			:DisplayObject {
			if(!container) container = Mview.getStage().stageRect;
			posX((container.width - obj.width) / 2 + delta, obj, trans2LT);
			return obj;
		}
		
		static public function right(obj:DisplayObject, delta:Number = 0, container:* = null, trans2LT:Boolean = false)
			:DisplayObject {
			if(!container) container = Mview.getStage().stageRect;
			posX(container.width - obj.width + delta, obj, trans2LT);
			return obj;
		}
		
		static public function top(obj:DisplayObject, delta:Number = 0, container:* = null, trans2LT:Boolean = false)
			:DisplayObject {
			if(!container) container = Mview.getStage().stageRect;
			posY(delta, obj, trans2LT);
			return obj;
		}
		
		static public function middle(obj:DisplayObject, delta:Number = 0, container:* = null, trans2LT:Boolean = false)
			:DisplayObject {
			if(!container) container = Mview.getStage().stageRect;
			posY((container.height - obj.height) / 2 + delta, obj, trans2LT);
			return obj;
		}
		
		static public function bottom(obj:DisplayObject, delta:Number = 0, container:* = null, trans2LT:Boolean = false)
			:DisplayObject {
			if(!container) container = Mview.getStage().stageRect;
			posY(container.height - obj.height + delta, obj, trans2LT);
			return obj;
		}
		
		static public function anchor(rx:Number, ry:Number, obj:DisplayObject, trans2LT:Boolean = false):DisplayObject {
			posX(-obj.width * rx, obj, trans2LT);
			posY(-obj.height * ry, obj, trans2LT);
			return obj;
		}
		
		static public function spaceHorazontal(begin:Number, end:Number, arr:Array, trans2LT:Boolean = true):void {
			var obj:DisplayObject;
			var widthCount:Number = 0;
			var i:int;
			for(i = 0; i < arr.length; ++i) {
				obj = arr[i];
				widthCount += obj.width;	
			}
			
			var space:Number =  (end - begin - widthCount) / (arr.length - 1);
			var px:Number = begin;
			for(i = 0; i < arr.length; ++i) {
				obj = arr[i];
				posX(px, obj, trans2LT);
				px += (obj.width + space);
			}
		}
		
		static public function spaceVertical(begin:Number, end:Number, arr:Array, trans2LT:Boolean = true):void {
			var obj:DisplayObject;
			var heightCount:Number = 0;
			var i:int;
			for(i = 0; i < arr.length; ++i) {
				obj = arr[i];
				heightCount += obj.height;	
			}
			
			var space:Number =  (end - begin - heightCount) / (arr.length - 1);
			var py:Number = begin;
			for(i = 0; i < arr.length; ++i) {
				obj = arr[i];
				posY(py, obj, trans2LT);
				py += (obj.height + space);
			}
		}
	}
}