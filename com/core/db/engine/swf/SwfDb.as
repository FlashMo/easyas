package com.core.db.engine.swf
{
	import com.core.db.Idb;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	
	public class SwfDb implements Idb
	{
		private var _swfMap:Object = new Object();		
		private var _classMap:Object = new Object();
		private var _staticMap:Object = new Object();
		
		public function loadSwf(k:String, val:ApplicationDomain):void {
			this._swfMap[k] = val;
		}
		
		public function getApplicationDomain(k:String):ApplicationDomain {
			return this._swfMap[k];
		}
		
		public function getClass(path:String):Class {
			if(_classMap[path] == null) {
				var arr:Array = path.split('/');
				if(arr.length == 2) {
					var domain:ApplicationDomain = this.getApplicationDomain(arr[0]);
					if(domain) {
						_classMap[path] = domain.getDefinition(arr[1]);
					}				
				}else {
					throw new Error('invalid path');
				}
			}
			return _classMap[path];
		}
		
		public function getBitmapData(path:String, useStatic:Boolean = true):BitmapData {
			if(useStatic) {
				if(this._staticMap[path] == null) {
					var c1:Class = this.getClass(path);				
					if(c1) {
						this._staticMap[path] = new c1();
					}	
				}
				return this._staticMap[path];
			}else {
				var c2:Class = this.getClass(path);
				if(c2) {
					return new c2();
				}else {
					return null;
				}
			}
		}
						
		public function getSound(path:String):Sound {
			if(this._staticMap[path] == null) {
				var c:Class = this.getClass(path);
				if(c) {
					this._staticMap[path] = new c();
				}
			}
			return this._staticMap[path];
		}
		
		public function getMovieClip(path:String):MovieClip {			
			var c:Class = this.getClass(path);
			if(c) {
				return new c() as MovieClip;
			}else {
				return null;
			}
		}
	}
}