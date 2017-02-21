package com.core.anima.base
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class AnimaBase
	{
		protected var _autoPlay:Boolean = true;
		protected var _onEnd:Function = null;
		protected var _loopOnEnd:Boolean = false;
		protected var _removeOnEnd:Boolean = false;
		protected var _hideOnEnd:Boolean = false;
		protected var _posX:Number = NaN;
		protected var _posY:Number = NaN;
		
		
		public function AnimaBase() {
			
		}
		
		public function pos(px:Number = NaN, py:Number = NaN):AnimaBase {
			this._posX = px;
			this._posY = py;
			return this;
		}
		
		public function autoPlay(val:Boolean=true):AnimaBase {
			this._autoPlay = val;
			return this;
		}
		
		/**
		 * 指定动画播完后调用的回调，若动画是循环播放的则每次播到末尾都会调用回调<br>
		 * 回调形式为 f(anima:AnimaBase):void
		 * */
		public function onEnd(val:Function):AnimaBase {
			this._onEnd = val;
			return this;
		}
		
		public function removeOnEnd(val:Boolean=true):AnimaBase {
			this._removeOnEnd = val;
			return this;
		}
		
		public function loopOnEnd(val:Boolean=true):AnimaBase {
			this._loopOnEnd = val;
			return this;
		}
		
		public function hideOnEnd(val:Boolean = true):AnimaBase {
			this._hideOnEnd = val;
			return this;
		}
		
		public function clone():AnimaBase {
			throw new Error('asb method called! BaseAnima.clone');
		}
		
		/**
		 * 动画是否正在播放
		 * */
		public function get playing():Boolean {
			throw new Error('asb method called! BaseAnima.playing');
		}
		
		public function play(p:DisplayObjectContainer):void {
			throw new Error('asb method called! BaseAnima.play');
		}
		
		public function stop(clean:Boolean=false):void {
			throw new Error('asb method called! BaseAnima.stop');
		}
		
		public function update(delta:Number=1):void {
			throw new Error('asb method called! BaseAnima.update');
		}
		
		protected function cloneBase(obj:AnimaBase):AnimaBase {
			obj._autoPlay = this._autoPlay;
			obj._onEnd = this._onEnd;
			obj._loopOnEnd = this._loopOnEnd;
			obj._removeOnEnd = this._removeOnEnd;
			obj._posX = this._posX;
			obj._posY = this._posY;
			return obj;
		}
	}
}