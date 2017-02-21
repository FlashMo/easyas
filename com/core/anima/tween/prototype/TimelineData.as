package com.core.anima.tween.prototype
{
	import com.core.anima.base.AnimaTarget;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class TimelineData
	{
		public static const TYPE_TWEEN:int = 1;
		public static const TYPE_TIMELINE:int = 2;
		public static const TYPE_MULTIPLE:int = 3;
		
		public var type:int = 1;
		public var vars:TweenLiteVars;
		public var time:Number;
		public var target:AnimaTarget;
		private var _arr:Array;
		
		public function TimelineData(type:int, time:Number = 0, vars:TweenLiteVars = null, target:AnimaTarget = null) {
			this.type = type;
			this.vars = vars;
			this.time = time;
			this.target = target
			if(this.type == TYPE_TIMELINE || this.type == TYPE_MULTIPLE) {
				this._arr = new Array();
			}
		}
		
		public function add(val:TimelineData):void {
			this._arr.push(val);
		}
		
		public function append2(p:DisplayObjectContainer, target:AnimaTarget, tm:TimelineLite):void {
			if(this.type == TYPE_MULTIPLE) {
				var tweens:Array = new Array();
				for(var i:int = 0; i < this._arr.length; ++i) {
					var row:TimelineData = this._arr[i];
					var anima:Animation = row.genAnima(p, target);
					if(anima) {
						tweens.push(anima);
					}
				}
				tm.appendMultiple(tweens);
			}else {
				tm.append(this.genAnima(p, target));
			}
		}
		
		public function genAnima(p:DisplayObjectContainer, target:AnimaTarget):Animation {
			var val:DisplayObject;
			if(this.target) {
				val = this.target.findAt(p, false);
			}else {
				val = target.findAt(p);
			}
			
			if(this.type == TYPE_TWEEN) {
				return new TweenLite(val, this.time, this.vars);
			}else if(this.type == TYPE_TIMELINE) {
				var tm:TimelineLite = new TimelineLite();
				for(var i:int = 0; i < this._arr.length; ++i) {
					var row:TimelineData = this._arr[i];
					row.append2(p, target, tm);
				}
				return tm;
			}else {
				return null;
			}
		}
	}
}