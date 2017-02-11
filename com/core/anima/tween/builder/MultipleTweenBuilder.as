package com.core.anima.tween.builder
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.TimelineLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObjectContainer;

	public class MultipleTweenBuilder implements ITweenBuilder
	{
		public var align:String;
		public var offset:Number;
		public var stagger:Number;
		private var _tweens:Array;
		
		public function MultipleTweenBuilder(tweens:Array = null, offset:Number = 0, align:String = 'normal', stagger:Number = 0) {
			this._tweens = (tweens != null) ? tweens : new Array();
			this.offset = offset;
			this.align = align;
			this.stagger = stagger;
		}
		
		public function addBuilder(builder:ITweenBuilder):void {
			this._tweens.push(builder);
		}
		
		public function genAnima(p:DisplayObjectContainer, factory:Function = null):Animation {
			return null;
		}
		
		public function append2TimeLine(timeline:TimelineLite, p:DisplayObjectContainer, func:Function = null):void {
			var arr:Array = new Array();
			for(var i:int = 0; i < this._tweens.length; ++i) {
				var b:ITweenBuilder = this._tweens[i];				
				arr.push(b.genAnima(p, func));
			}
			timeline.appendMultiple(arr, this.offset, this.align, this.stagger);
		}
		
		public function clone():MultipleTweenBuilder {
			var arr:Array = new Array();
			for(var i:int = 0; i < this._tweens.length; ++i) {
				var b:TweenBuilder = this._tweens[i];
				arr.push(b.clone());
			}
			return new MultipleTweenBuilder(arr, this.offset, this.align, this.stagger);
		}
	}
}