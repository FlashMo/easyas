package com.core.anima.tween
{
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.BaseAnima;
	import com.core.anima.base.DummyTarget;
	import com.core.anima.base.IAnima;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.data.TweenMaxVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import com.core.anima.tween.builder.TweenBuilder;

	public class TweenAnima extends BaseAnima
	{
		private var _builder:TweenBuilder;
		private var _tween:TweenLite;
		public function TweenAnima(builder:TweenBuilder = null) {
			this._builder = (builder != null) ? builder : 
				new TweenBuilder(new AnimaTarget(), 0, new TweenLiteVars());			
		}		
		
		public function setTarget(name:String, c:Class = null):TweenAnima {
			this._builder.target.targetName = name;
			this._builder.target.targetClass = c;						
			return this;
		}
		
		public function time(val:Number):TweenAnima {
			this._builder.time = val;
			return this;
		}	
			
		public function get vars():TweenLiteVars {
			return this._builder.vars;
		}
		
		override public function clone():IAnima {			
			var tmp:TweenAnima = new TweenAnima(this._builder.clone());
			this.cloneBase(tmp);							
			return tmp;
		}
		
		override public function get playing():Boolean {
			return this._tween != null;
		}
		
		override public function play(p:DisplayObjectContainer, px:Number=0, py:Number=0):void {						
			this._builder.vars.onComplete(this._onComplete);			
			var target:DisplayObject = this._builder.load(p, this._targetFactory);
			target.x = px;
			target.y = py;
			this._tween = this._builder.gen();								
		}
		
		public function pause():void {
			if(this._tween) this._tween.pause();
		}
		
		public function resume():void {
			if(this._tween) this._tween.resume();
		}
		
		override public function stop(clean:Boolean=true):void {
			if(this._tween) {
				this._tween.kill();
				this._tween = null;
			}			
			if(clean) {				
				this._builder.target.clean();
			}
		}
		
		private function _onComplete():void {
			if(this._onEnd != null) {
				this._onEnd(this);
			}
			if(this._removeOnEnd) {
				this.stop(true);
				return;
			}
			if(this._loopOnEnd) {				
				this._tween.restart();
			}else {
				this.stop(false);
			}			
		}
		
		private function _targetFactory(p:DisplayObjectContainer, data:AnimaTarget):DisplayObject {
			var c:Class = data.targetClass;
			if(!c) c = DummyTarget;
			var target:DisplayObject = new c();
			if(data.targetName) {
				target.name = data.targetName;	
			}
			p.addChild(target);
			return target;			
		}
	}
}