package com.core.anima.tween.prototype
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class TimelineTweenPrototype extends TweenPrototypeBase
	{
		private var _stack:Array;
		
		public function TimelineTweenPrototype() {
			this._stack = new Array(new TimelineData(TimelineData.TYPE_TIMELINE));
		}
		
		public function add(time:Number, vars:TweenLiteVars, target:AnimaTarget = null):TimelineTweenPrototype {
			this.top.add(new TimelineData(TimelineData.TYPE_TWEEN, time, vars, target));
			return this;
		}
		
		public function beginMultiple():TimelineTweenPrototype {
			this.push(new TimelineData(TimelineData.TYPE_MULTIPLE));
			return this;
		}
		
		public function endMutiple():TimelineTweenPrototype {			
			this.pop();
			return this;
		}
		
		public function beginTimeline():TimelineTweenPrototype {
			this.push(new TimelineData(TimelineData.TYPE_TIMELINE));
			return this;
		}
		
		public function endTimeline():TimelineTweenPrototype {
			this.pop();
			return this;
		}
		
		override public function genAnima(p:DisplayObjectContainer, target:AnimaTarget):Animation {
			var tm:Animation = this.root.genAnima(p, target);
			tm.play();
			return tm;
		}
		
		private function get top():TimelineData {
			return this._stack[this._stack.length - 1];
		}
		
		private function get root():TimelineData {
			return this._stack[0];
		}
		
		private function push(val:TimelineData):void {
			this._stack.push(val);
		}
		
		private function pop():void {
			if(this._stack.length > 1) {
				var val:TimelineData = this._stack.pop();	
				this.top.add(val);
			}
		}	
			
		
	}
}