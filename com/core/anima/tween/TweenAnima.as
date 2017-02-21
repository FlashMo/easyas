package com.core.anima.tween
{
	import com.core.anima.base.AnimaBase;
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.DummyTarget;
	import com.core.anima.tween.builder.TweenBuilder;
	import com.core.anima.tween.prototype.TweenPrototypeBase;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.data.TweenMaxVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class TweenAnima extends AnimaBase
	{
		private var _prototype:TweenPrototypeBase;
		private var _anima:Animation;
		private var _target:AnimaTarget;
		public function TweenAnima(prototype:TweenPrototypeBase = null) {
			this.prototype(prototype);
		}
		
		public function prototype(val:TweenPrototypeBase):TweenAnima {
			if(val) {
				if(this._prototype) this.stop();
				this._prototype = val;	
				this._target = this._prototype.genTarget();
			}			
			return this;
		}
		
		override public function clone():AnimaBase {			
			return this.cloneBase(new TweenAnima(this._prototype));
		}
		
		/**
		 * 动画是否在播放。注意只有动画处于停止状态时playing为false，暂停状态时playing也为true
		 * */
		override public function get playing():Boolean {
			return this._anima != null;
		}
		
		override public function play(p:DisplayObjectContainer):void {
			this.stop(false);
			this._anima = this._playSub(p, this._target);	
			this._anima.vars.onComplete = this._onComplete;
		}
		
		protected function _playSub(p:DisplayObjectContainer, target:AnimaTarget):Animation {
			return this._prototype.genAnima(p, this._target);
		}
		
		override public function stop(clean:Boolean=true):void {
			if(this._anima) {
				this._anima.kill();
				this._anima = null;
			}			
			if(clean) {
				this._target.clean();
			}
		}
		
		/**
		 * 暂停动画
		 * @param time 将动画暂停到的时间点，若为null暂停到当前时间点
		 * @param p 播放动画的容器，指定了这个参数时若动画还未播放会先在p中播放然后立刻暂停到指定时间点
		 * 若动画未播放且没有指定p参数，则操作无效
		 * */
		public function pause(time:* = null, p:DisplayObjectContainer = null):void {
			if(this._anima) {
				this._anima.pause(time);
			}else if(p) {
				this.play(p);
				this.pause(time);
			}
		}
		
		/**
		 * 恢复播放动画
		 * @param time 动画播放的时间点，若为null从当前位置开始播放
		 * @param p 播放动画的容器，指定了这个参数时若动画还未播放会先在p中播放然后立刻跳转到指定时间点播放。
		 * 若动画未播放且没有指定p参数，则操作无效
		 * */
		public function resume(time:* = null, p:DisplayObjectContainer = null):void {
			if(this._anima) {
				this._anima.resume(time);
			}else if(p) {
				this.play(p);
				this.resume(time);
			}
		}
		
		protected function _onComplete():void {
			if(this._onEnd != null) {
				this._onEnd(this);
			}
			if(this._removeOnEnd) {
				this.stop(true);
				return;
			}
			if(this._loopOnEnd) {				
				this._anima.restart();
			}else {
				this.stop(false);
			}			
		}
	}
}