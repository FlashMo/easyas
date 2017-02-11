package com.core.db.loader
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	/**
	 * 多文件加载类：加载多个文件，在所有文件加载完成后回调并返回各个文件的数据。
	 * */
	public class MultiLoader extends EventDispatcher
	{
		private var _loadMap:Object = new Object();
		private var _dataMap:Object = new Object();
		
		public function clear():void {
			for(var key:String in _loadMap) {
				if(_loadMap[key] != null) {
					var dispatcher:EventDispatcher = _loadMap[key] as EventDispatcher;
					dispatcher.removeEventListener(Event.COMPLETE, onLoadComplete);
				}
			}
			_loadMap = new Object();
			_dataMap = new Object();
		}
		
		public function start():void {
			updateState();
		}
		
		public function addLoader(key:String, url:String):void {
			var request:URLRequest = new URLRequest(url);
			var loader:Loader = new Loader();
			_loadMap[key] = loader.contentLoaderInfo;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			//loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(request);
			
		}
		
		public function addURLLoader(key:String, url:String):void {
			var request:URLRequest = new URLRequest(url);
			var l:URLLoader = new URLLoader(request);
			_loadMap[key] = l;
			l.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		public function addData(key:String, l:*):void {
			_dataMap[key] = l;
		}
		
		public function getXMLData(key:String):XML {
			return XML(getData(key));
		}
		
		public function getStringData(key:String):String {
			return String(getData(key));
		}
		
		public function getSwfData(key:String):ApplicationDomain {
			return getData(key) as ApplicationDomain;
		}
		
		public function getData(key:String):* {
			if(!_dataMap.hasOwnProperty(key)) {
				throw new Error('key not exist');
			}
			return _dataMap[key];	
		}
		
		private function onLoadComplete(e:Event):void {
			var loaderKey:String = null;
			for(var key:String in _loadMap) {
				if(_loadMap[key] == e.target) {
					trace(key);
					_loadMap[key] = null;
					if(e.target is LoaderInfo) {
						var loaderInfo:LoaderInfo = e.target as LoaderInfo;
						_dataMap[key] = loaderInfo.applicationDomain;
					}else if(e.target is URLLoader) {
						var urlLoader:URLLoader = e.target as URLLoader;
						_dataMap[key] = urlLoader.data;
					}
					break;
				}
			}
			e.target.removeEventListener(Event.COMPLETE, onLoadComplete);
			updateState();
		}
		
		private function updateState():void {
			for(var key:String in _loadMap) {
				if(_loadMap[key] != null) {
					//trace(key);
					return;
				}
			}
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onLoadError(e:Event):void {
			
		}
	}
}