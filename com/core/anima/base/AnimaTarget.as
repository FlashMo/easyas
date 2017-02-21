package com.core.anima.base
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * 动画目标类，通过name在container中查找目标，若指定name的对象不存在则设法创建一个动画目标。
	 * */
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
			tmp.setVal(this._target);
			return tmp;
		}
		
		/**
		 * 在容器内寻找一个显示对象，若找不到则尝试创建它
		 * @param p 要查找的容器
		 * @param save 可选 是否保存找到的对象，默认保存
		 * */
		public function findAt(p:DisplayObjectContainer, save:Boolean = true):DisplayObject {
			if(!p) return this._target;
			if(this._target && this._target.parent == p) return this._target;
			this._target = null;
			if(this.targetName) {
				this._target = p.getChildByName(this.targetName);	
			}			 						
			if(!this._target && this.targetClass != null) {
				this._target = new (this.targetClass)();
				this._target.name = this.targetName;
				p.addChild(this._target);
			}
			if(!this._target) {
				this._target = new DummyTarget();
				if(this.targetName) this._target.name = this.targetName;				
				p.addChild(this._target);
			}
			
			var r:DisplayObject = this._target;
			if(!save) this._target = null;
			return r;
		}
		
		public function setVal(val:DisplayObject):void {
			this._target = val;
		}
		
		public function clean():void {
			if(this._target && this._target.parent) {
				this._target.parent.removeChild(this._target);
			}
			this._target = null;
		}
		
		public function get val():DisplayObject {
			return this._target;
		}
		
		public function get clipVal():MovieClip {
			return this._target as MovieClip;
		}
		
		public function get spriteVal():Sprite {
			return this._target as Sprite;
		}
		
		public function get bitmapVal():Bitmap {
			return this._target as Bitmap;
		}
	}
}