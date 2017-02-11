package com.core.anima
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class BaseAnima implements IAnima
	{
		protected var _autoPlay:Boolean = true;
		protected var _onEnd:Function = null;
		protected var _loopOnEnd:Boolean = false;
		protected var _removeOnEnd:Boolean = false;
		
		
		public function autoPlay(val:Boolean=true):BaseAnima {
			this._autoPlay = val;
			return this;
		}
		
		public function onEnd(val:Function):BaseAnima {
			this._onEnd = val;
			return this;
		}
		
		public function removeOnEnd(val:Boolean=true):BaseAnima {
			this._removeOnEnd = val;
			return this;
		}
		
		public function loopOnEnd(val:Boolean=true):BaseAnima {
			this._loopOnEnd = val;
			return this;
		}
		
		protected function cloneBase(obj:BaseAnima):BaseAnima {
			obj._autoPlay = this._autoPlay;
			obj._onEnd = this._onEnd;
			obj._loopOnEnd = this._loopOnEnd;
			obj._removeOnEnd = this._removeOnEnd;
			return obj;
		}
		
		public function get playing():Boolean {
			return false;
		}
		
		public function clone():IAnima {
			throw new Error('abs method called! BaseAnima.clone');
		}
		
		public function update(delta:Number=1):void {
			throw new Error('asb method called! BaseAnima.update');
		}
		
		public function play(p:DisplayObjectContainer, px:Number=0, py:Number=0):void {
			throw new Error('asb method called! BaseAnima.play');
		}
		
		public function stop(clean:Boolean=true):void {
			throw new Error('asb method called! BaseAnima.stop');
		}
	}
}