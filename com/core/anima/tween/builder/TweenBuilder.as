package com.core.anima.tween.builder
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class TweenBuilder implements ITweenBuilder
	{
		public var offset:Number;
		public var target:AnimaTarget;
		public var time:Number;
		public var vars:TweenLiteVars;
		
		public function TweenBuilder(target:AnimaTarget, time:Number, vars:TweenLiteVars, offset:Number = 0)
		{
			this.target = target;
			this.time = time;
			this.vars = vars;
			this.offset = offset;
		}
		
		public function load(p:DisplayObjectContainer, func:Function):DisplayObject {
			return this.target.load(p, func);			
		}
		
		public function gen():TweenLite {			
			return new TweenLite(this.target.val, this.time, this.vars);
		}
		
		public function genAnima(p:DisplayObjectContainer, factory:Function = null):Animation {
			return new TweenLite(this.target.load(p, factory), this.time, this.vars);
		}
		
		public function append2TimeLine(timeline:TimelineLite, p:DisplayObjectContainer, func:Function = null):void {
			timeline.append(this.genAnima(p, func), this.offset);
		}
		
		public function clone():TweenBuilder {			
			var tmp:TweenBuilder = new TweenBuilder(
				new AnimaTarget(this.target.targetName, this.target.targetClass),
				this.time,
				new TweenLiteVars(this.vars.vars)
			);
			return tmp;
		}
	}
}