package com.core.anima.frame
{
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.BaseAnima;
	import com.core.anima.base.IAnima;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class FrameAnima extends BaseAnima
	{
		private var _dpos:Point;		
		private var _frames:Array = new Array();
		private var _cur:Number;
		private var _length:int;
		private var _target:AnimaTarget = new AnimaTarget();
		private var _listenOnFrame:Boolean = false;		
		private var _playing:Boolean = false;
		
		public function dpos(px:Number, py:Number):FrameAnima {
			this._dpos = new Point(px, py);
			return this;
		}
		
		public function frame(delta:int):FrameAnima {
			this._length += delta;
			return this;
		}
		
		public function frameAt(pos:int):FrameAnima {
			if(this._length < pos) this._length = pos;
			return this;
		}
		
		public function keyFrame(delta:int, bitmapData:BitmapData):FrameAnima {
			this._length += delta;
			this._frames[this._length] = bitmapData;
			return this;
		}
		
		public function keyFrameAt(pos:int, bitmapData:BitmapData):FrameAnima {
			if(this._length < pos) this._length = pos;
			this._frames[pos] = bitmapData;
			return this;
		}
		
		public function setTarget(name:String):FrameAnima {
			this._target.targetName = name;
			return this;
		}
		
		public function get length():int {
			return this._length;
		}
		
		override public function get playing():Boolean {
			return this._playing;
		}
		
		override public function clone():IAnima {
			var tmp:FrameAnima = new FrameAnima();
			this.cloneBase(tmp);
			tmp._dpos = this._dpos;
			tmp._frames = this._frames;
			tmp._length = this._length;
			tmp._target = this._target.clone();
			return tmp;
		}
		
		override public function play(p:DisplayObjectContainer, px:Number=0, py:Number=0):void {
			this.stop(false);
			this._target.load(p, this._targetFactory);
			this._target.val.x = px;
			this._target.val.y = py;
			if(this._dpos) {
				this._target.val.x += this._dpos.x;
				this._target.val.y += this._dpos.y;
			}
			this._cur = 1;
			this._renderFrame();
			if(this._autoPlay && !this._listenOnFrame) {
				this._target.val.addEventListener(Event.ENTER_FRAME, this._onFrame);
				this._listenOnFrame = true;
			}
			this._playing = true;
		}
		
		override public function stop(clean:Boolean=true):void {
			if(this._listenOnFrame && this._target.val) {					
				this._target.val.removeEventListener(Event.ENTER_FRAME, this._onFrame);	
				this._listenOnFrame = false;
			}
			if(clean) {				
				this._target.clean();
			}
			this._playing = false;
		}
		
		override public function update(delta:Number=1):void {
			if(!this._playing) return;
			this._cur += delta;
			if(int(this._cur) > this._length) {				
				if(this._onEnd != null) {
					this._onEnd(this);
				}				
				if(this._removeOnEnd) {
					this.stop(true);
					return;
				}				
				if(this._loopOnEnd) {
					this._cur = 1;
				}else {
					this._cur = this._length;					
					if(this._listenOnFrame) {					
						this._target.val.removeEventListener(Event.ENTER_FRAME, this._onFrame);
						this._listenOnFrame = false;
					}
				}																
			}
			this._renderFrame();
		}
		
		private function _renderFrame():void {
			var data:BitmapData = this._frames[int(this._cur)];
			if(data) {
				var bmp:Bitmap = (this._target.val) as Bitmap;
				bmp.bitmapData = data;
			}
		}		
		
		private function _targetFactory(p:DisplayObjectContainer, data:AnimaTarget):DisplayObject {
			var val:Bitmap = new Bitmap();
			val.name = data.targetName;
			p.addChild(val);
			return val;
		}
		
		private function _onFrame(e:Event):void {
			this.update();
		}
	}
}