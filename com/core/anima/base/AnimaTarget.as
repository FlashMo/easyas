package com.core.anima.base
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class AnimaTarget
	{
		public var targetName:String;
		public var targetClass:Class;
		private var _target:DisplayObject;
		
		/**
		 * AnimaTarget helps find animation target from parent
		 * @param targetName the child name of animation target.
		 * @param targetClass the class of animation target helps create animation target.  
		 * */
		public function AnimaTarget(targetName:String = '', targetClass:Class = null) {
			this.targetName = targetName;			
			this.targetClass = targetClass;			
		}
		
		public function clone():AnimaTarget {
			var tmp:AnimaTarget = new AnimaTarget(this.targetName, this.targetClass);
			return tmp;
		}
		
		/**
		 * load anima target from parent
		 * @param p the parent
		 * @param factory if there is no child with targetName call the factoryFunc to create animation target
		 *  the formate of factoryFunc is <br> func(p:DisplayObjectContainer, data:AnimaTarget):DisplayObject.
		 * */
		public function load(p:DisplayObjectContainer, factory:Function = null):DisplayObject {
			this._target = null;
			if(this.targetName) {
				this._target = p.getChildByName(this.targetName);	
			}			 						
			if(!this._target) {
				if(factory != null) {
					this._target = factory(p, this);					
				}else if(this.targetClass != null){
					this._target = new (this.targetClass)();
					this._target.name = this.targetName;
					p.addChild(this._target);
				}
			}
			if(!this._target) {
				this._target = new DummyTarget();
				if(this.targetName) this._target.name = this.targetName;				
				p.addChild(this._target);
			}			
			return this._target;
		}
		
		public function get val():DisplayObject {
			return this._target;
		}
		
		public function clean():void {
			if(this._target && this._target.parent) {
				this._target.parent.removeChild(this._target);
			}
			this._target = null;
		}
	}
}