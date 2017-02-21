package com.core.anima.tween.prototype
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.core.Animation;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class CustomTweenPrototype extends TweenPrototypeBase
	{
		private var _target:AnimaTarget = new AnimaTarget();
		private var _func:Function = null;
		
		/**
		 * 设置自定义的创建Animation的函数。<br>
		 * 形式为 f(p:DisplayObjectContainer, target:AnimaTarget):Animation<br>
		 * 其中p为要播放动画的容器，target为动画对象
		 * */
		public function func(f:Function):CustomTweenPrototype {
			this._func = f;
			return this;
		}
		
		override public function genAnima(p:DisplayObjectContainer, target:AnimaTarget):Animation {
			return this._func(p, target);
		}
	}
}