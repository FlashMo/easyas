package com.core.anima.tween
{
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.BaseAnima;
	import com.core.anima.tween.builder.ITweenBuilder;
	import com.core.anima.tween.builder.MultipleTweenBuilder;
	import com.core.anima.tween.builder.TweenBuilder;
	import com.greensock.TimelineLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObjectContainer;
	
	public class TimeLineAnima extends BaseAnima implements ITweenBuilder
	{
		private var _timeline:TimelineLite = null;
		private var _multipleBuilder:MultipleTweenBuilder;
		private var _arr:Array = null;
		
		public function TimeLineAnima(arr:Array = null) {
			this._arr = (arr != null) ? arr : new Array();
		}
		
		public function addTween(target:AnimaTarget, time:Number, vars:TweenLiteVars, offset:Number = 0):TimeLineAnima {
			if(this._multipleBuilder) {
				this._multipleBuilder.addBuilder(new TweenBuilder(target, time, vars, offset));
			}else {
				this._arr.push(new TweenBuilder(target, time, vars, offset));
			}
			return this
		}
		
		public function addTimeLineAnima(timelineAnima:TimeLineAnima):TimeLineAnima {
			if(this._multipleBuilder) {
				this._multipleBuilder.addBuilder(timelineAnima);
			}else {
				this._arr.push(timelineAnima);
			}
			return this;
		}
		
		public function beginMultiple(offset:Number = 0, align:String = 'normal', stagger:Number = 0, arr:Array = null)
			:TimeLineAnima {
			if(!this._multipleBuilder) {
				this._multipleBuilder = new MultipleTweenBuilder(arr, offset, align, stagger);
			}
			return this;
		}
		
		public function endMultiple():TimeLineAnima {
			if(this._multipleBuilder) {
				this._arr.push(this._multipleBuilder);
				this._multipleBuilder = null;
			}
			return this;
		}
		
		override public function get playing():Boolean {
			return this._timeline != null;
		}
		
		override public function play(p:DisplayObjectContainer, px:Number=0, py:Number=0):void {
			this._timeline = this.genAnima(p) as TimelineLite;
			this._timeline.play();
		}
		
		override public function stop(clean:Boolean=true):void {
			this._timeline.kill();
			this._timeline = null;			
		}
		
		public function genAnima(p:DisplayObjectContainer, factory:Function = null):Animation {
			var timeLine:TimelineLite = new TimelineLite({onComplete: this._onComplete});
			for(var i:int = 0; i < this._arr.length; ++i) {
				var t:ITweenBuilder = this._arr[i];
				t.append2TimeLine(timeLine, p, null);
			}
			return timeLine;
		}
		
		public function append2TimeLine(timeline:TimelineLite, p:DisplayObjectContainer, func:Function = null):void {
			timeline.add(this.genAnima(p));
		}
		
		private function _onComplete():void {
			if(this._removeOnEnd) {
				this.stop(true);
			}
			if(this._loopOnEnd) {
				this._timeline.restart();
			}else {
				this.stop(false);
			}
		}
	}
}