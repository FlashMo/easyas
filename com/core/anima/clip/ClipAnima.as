package com.core.anima.clip
{
	import com.core.anima.AnimaTarget;
	import com.core.anima.BaseAnima;
	import com.core.anima.DummyTarget;
	import com.core.anima.IAnima;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ClipAnima extends BaseAnima
	{
		private var _cur:Number;		
		private var _start:int = 0;
		private var _startLabel:String;
		private var _end:int = 0;
		private var _endLabel:String;		
		private var _target:AnimaTarget = new AnimaTarget();
		private var _listenOnFrame:Boolean = false;
		private var _playing:Boolean = false;
		
		public function setTarget(name:String, c:Class):ClipAnima {
			this._target.targetName = name;
			this._target.targetClass = c;
			return this;
		}
		
		public function clipByLabel(startLabel:String, endLabel:String = ''):ClipAnima {
			this._startLabel = startLabel;
			this._endLabel = endLabel;
			return this;
		}
		
		public function clipByFrame(start:int, end:int = 0):ClipAnima {
			this._start = start;
			this._end = end;
			return this;
		}
		
		public function get length():int {
			return this._end - this._start;
		}
		
		override public function get playing():Boolean {
			return this._playing;
		}
		
		override public function clone():IAnima {
			var tmp:ClipAnima = new ClipAnima;
			this.cloneBase(tmp);
			tmp._target = this._target.clone();
			tmp._startLabel = this._startLabel;
			tmp._start = this._start;
			tmp._endLabel = this._endLabel;
			tmp._end = this._end;
			return tmp;
		}
		
		override public function play(p:DisplayObjectContainer, px:Number=0, py:Number=0):void {
			this.stop(false);
			var clip:MovieClip = this._target.load(p) as MovieClip;
			clip.stop();
			clip.x = px;
			clip.y = py;			
			if(this._start <= 0) {
				if(this._startLabel) this._start = this._findFrameByLabel(this._startLabel, clip); 			
				if(this._start <= 0) this._start = 1;
			}
			if(this._end <= 0) {
				if(this._endLabel) this._end = this._findFrameByLabel(this._endLabel, clip);
				if(this._end <= 0) this._end = clip.totalFrames + 1;	
			}
			this._cur = this._start;			
			clip.gotoAndStop(this._cur);
			if(this._autoPlay && !this._listenOnFrame) {
				clip.addEventListener(Event.ENTER_FRAME, this._onFrame);
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
			if(this._cur >= this._end) {
				if(this._onEnd != null) {
					this._onEnd(this);
				}
				if(this._removeOnEnd) {
					this.stop(true);
					return;
				}
				if(this._loopOnEnd) {
					this._cur = this._start;
				}else {
					this._cur = this._end - 1;
					this.stop(false);
				}
			}
			
			var clip:MovieClip = this._target.val as MovieClip;
			var d:int = this._cur - clip.currentFrame;
			if(d) {
				if(d == 1) {
					clip.nextFrame();
				}else {
					clip.gotoAndStop(int(this._cur));
				}	
			}			
		}
		
		private function _onFrame(e:Event):void {
			this.update();
		}		
		
		private function _findFrameByLabel(label:String, clip:MovieClip):int {
			var arr:Array = clip.currentLabels;
			for(var i:int = 0; i < arr.length; ++i) {
				var f:FrameLabel = arr[i];
				if(f.name == label) {
					return f.frame;
				}
			}
			return 0;
		}
	}
}