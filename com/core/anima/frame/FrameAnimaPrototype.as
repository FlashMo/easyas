package com.core.anima.frame
{
	import com.core.anima.base.AnimaTarget;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	public class FrameAnimaPrototype
	{
		private var _frames:Array = new Array(); //BitmapData帧数组
		private var _length:int; //总帧数
		private var _target:AnimaTarget = new AnimaTarget('', Bitmap);
		
		public function genTarget():AnimaTarget {
			return this._target.clone();
		}
		
		public function get frameTotal():int {
			return this._length;
		}
		
		public function get frames():Array {
			return this._frames;
		}
		
		public function target(name:String, val:DisplayObject = null):FrameAnimaPrototype {
			this._target.targetClass = Bitmap;
			this._target.targetName = name;
			this._target.setVal(val);
			return this;
		}
		
		public function frame(delta:int):FrameAnimaPrototype {
			this._length += delta;
			return this;
		}
		
		public function frameAt(pos:int):FrameAnimaPrototype {
			if(this._length < pos) this._length = pos;
			return this;
		}
		
		public function keyFrame(delta:int, bitmapData:BitmapData):FrameAnimaPrototype {
			this._length += delta;
			this._frames[this._length] = bitmapData;
			return this;
		}
		
		public function keyFrameAt(pos:int, bitmapData:BitmapData):FrameAnimaPrototype {
			if(this._length < pos) this._length = pos;
			this._frames[pos] = bitmapData;
			return this;
		}
	}
}