package com.core.anima.tween.prototype
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObjectContainer;

	public class SimpleTweenPrototype extends TweenPrototypeBase
	{
		private var _vars:TweenLiteVars = null;
		private var _time:Number = 1;
		
		public function time(val:Number):SimpleTweenPrototype {			
			this._time = val;
			return this;
		}
		
		public function vars(val:TweenLiteVars):SimpleTweenPrototype {
			this._vars = val;
			return this;
		}
		
		override public function genAnima(p:DisplayObjectContainer, target:AnimaTarget):Animation {
			var vars:TweenLiteVars = (this._vars != null) ? new TweenLiteVars(this._vars.vars) : new TweenLiteVars(); 
			return new TweenLite(target.findAt(p), this._time, vars);
		}
	}
}