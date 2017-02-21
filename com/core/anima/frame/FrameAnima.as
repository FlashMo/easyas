package com.core.anima.frame
{
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.AnimaBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class FrameAnima extends AnimaBase
	{
		private var _prototype:FrameAnimaPrototype; 		
		
		private var _cur:Number; //当前播放帧
		private var _length:Number = 0; //动画总帧数
		private var _frames:Array;
		private var _target:AnimaTarget = new AnimaTarget(); //动画对象
		private var _listening:Boolean = false; //是否在监听逐帧事件		
		private var _playing:Boolean = false; //是否在播放
		
		public function FrameAnima(pt:FrameAnimaPrototype = null) {
			this.prototype(pt);
		}
		
		public function prototype(pt:FrameAnimaPrototype):FrameAnima {
			if(pt) {
				if(this._prototype) this.stop(false);
				this._prototype = pt;
				this._target = this._prototype.genTarget();
				this._length = this._prototype.frameTotal;
				this._frames = this._prototype.frames;
			}
			return this;
		}
		
		override public function clone():AnimaBase {
			return this.cloneBase(new FrameAnima(this._prototype));
		}
		
		public function get length():int {
			return this._length;
		}
		
		override public function get playing():Boolean {
			return this._playing;
		}
		
		/**
		 * play之前必须保证设置prototype和parent
		 * */
		override public function play(p:DisplayObjectContainer):void {
			this.stop(false);
			this._target.findAt(p); //从container中找到动画对象
			this._target.val.visible = true; //动画对象可见
			if(!isNaN(this._posX)) this._target.val.x = this._posX;
			if(!isNaN(this._posY)) this._target.val.y = this._posY;
			this._cur = 1;
			this._renderFrame();
			if(this._autoPlay && !this._listening) {
				this._target.val.addEventListener(Event.ENTER_FRAME, this._onFrame);
				this._listening = true;
			}
			this._playing = true;
		}
		
		override public function stop(clean:Boolean=false):void {
			if(this._listening && this._target.val) {					
				this._target.val.removeEventListener(Event.ENTER_FRAME, this._onFrame);	
				this._listening = false;
			}
			if(clean) {				
				this._target.clean();
			}
			this._playing = false;
		}
		
		override public function update(delta:Number=1):void {
			if(!this._playing) return;
			this._cur += delta;
			if(int(this._cur) > this.length) {				
				if(this._onEnd != null) {
					this._onEnd(this);
				}				
				if(this._removeOnEnd) {
					this.stop(true);
					return;
				}else if(this._hideOnEnd){
					this._target.val.visible = false;
					this._cur = this.length;
					this.stop(false);
				}if(this._loopOnEnd) {
					this._cur = 1;
				}else {
					this._cur = this.length;
					this.stop(false);
				}																
			}
			this._renderFrame();
		}
		
		private function _renderFrame():void {
			var data:BitmapData = this._frames[int(this._cur)];
			if(data) this._target.bitmapVal.bitmapData = data;
		}		
		
		private function _onFrame(e:Event):void {
			this.update();
		}
	}
}