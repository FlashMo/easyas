package com.core.anima.clip
{
	import com.core.anima.base.AnimaTarget;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;

	public class ClipAnimaPrototype
	{
		private var _start:int = 0; //开始帧
		private var _startLabel:String; //开始帧label
		private var _end:int = 0; //结束帧
		private var _endLabel:String;	//结束帧label
		private var _target:AnimaTarget = new AnimaTarget(); //动画对应的movieclip信息
		
		public function genStart(m:MovieClip):int {
			if(this._start <= 0) {
				var pos:int = 0;
				if(this._startLabel) pos = this._findFrameByLabel(this._startLabel, m);
				if(!pos) pos = 1;
				return pos;	
			}else {
				return this._start;
			}
		}
		
		public function genEnd(m:MovieClip):int {
			if(this._end <= 0) {
				var pos:int = 0;
				if(this._endLabel) pos = this._findFrameByLabel(this._endLabel, m);
				if(!pos) pos = m.totalFrames + 1;
				return pos;
			}else {
				return this._end;
			}
		}
		
		public function genTarget():AnimaTarget {
			return this._target.clone();
		}
		
		public function target(name:String, c:Class, val:MovieClip = null):ClipAnimaPrototype {
			this._target.targetName = name;
			this._target.targetClass = c;
			this._target.setVal(val);
			return this;
		}
		
		public function clipByLabel(startLabel:String, endLabel:String = ''):ClipAnimaPrototype {
			this._startLabel = startLabel;
			this._endLabel = endLabel;
			return this;
		}
		
		public function clipByFrame(start:int, end:int = 0):ClipAnimaPrototype {
			this._start = start;
			this._end = end;
			return this;
		}
		
		private function _findFrameByLabel(label:String, clip:MovieClip):int {
			var arr:Array = clip.currentLabels;
			for(var i:int = 0; i < arr.length; ++i) {
				var f:FrameLabel = arr[i];
				if(f.name == label) {
					return f.frame;
				}
			}
			return 0;
		}
	}
}