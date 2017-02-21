package com.core.anima.clip
{
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.AnimaBase;
	import com.core.anima.base.DummyTarget;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ClipAnima extends AnimaBase
	{
		private var _prototype:ClipAnimaPrototype; //动画数据
		private var _cur:Number;	//当前播放到的帧	
		private var _start:int = 0; //开始帧
		private var _end:int = 0; //结束帧
		private var _target:AnimaTarget; //动画对应的movieclip信息
		private var _listening:Boolean = false; //是否在监听逐帧事件
		private var _playing:Boolean = false; //是否在播放
		
		public function ClipAnima(proptotype:ClipAnimaPrototype = null) {
			this.prototype(proptotype);
		}
		
		public function prototype(prototype:ClipAnimaPrototype):ClipAnima {
			if(prototype) {
				if(this._prototype) this.stop(false);
				this._prototype = prototype;
				this._target = prototype.genTarget();
			}
			return this;
		}
		
		public function get length():int {
			return this._end - this._start;
		}
		
		override public function clone():AnimaBase {
			return this.cloneBase(new ClipAnima(this._prototype));
		}
		
		override public function get playing():Boolean {
			return this._playing;
		}
		
		/**
		 * play之前必须保证设置prototype
		 * */
		override public function play(p:DisplayObjectContainer):void {
			this.stop(false);
			this._target.findAt(p); //从container中找到动画对象
			this._target.val.visible = true; //动画对象可见
			if(!isNaN(this._posX)) this._target.val.x = this._posX;
			if(!isNaN(this._posY)) this._target.val.y = this._posY;
			this._start = this._prototype.genStart(this._target.clipVal);
			this._end = this._prototype.genEnd(this._target.clipVal);
			this._cur = this._start;
			this._target.clipVal.gotoAndStop(this._cur);
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
			if(clean) this._target.clean();
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
				}else if(this._hideOnEnd) {
					this._target.val.visible = false;
					this._cur = this._end - 1;
					this.stop(false);
				}else if(this._loopOnEnd) {				 
					this._cur = this._start;
				}else {
					this._cur = this._end - 1;
					this.stop(false);
				}
			}
			
			//尽量使用nextFrame 不确定是否对性能有利
			var clip:MovieClip = this._target.clipVal;
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
	}
}