package com.core.anima.tween.prototype
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.core.Animation;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class TweenPrototypeBase
	{
		private var _target:AnimaTarget = new AnimaTarget();
		public function target(name:String, cls:Class, val:DisplayObject):TweenPrototypeBase {
			this._target.targetName = name;
			this._target.targetClass = cls;
			this._target.setVal(val);
			return this;
		}
		
		public function genTarget():AnimaTarget {
			return this._target.clone();
		}
		
		public function genAnima(p:DisplayObjectContainer, target:AnimaTarget):Animation {
			throw new Error('abs method called! TweenPrototypeBase.genAnima');
		}
	}
}