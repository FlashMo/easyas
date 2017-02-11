package com.core.db.engine.json
{
	import com.core.db.Idb;
	
	import flash.utils.getQualifiedClassName;
	
	public class JsonDb implements Idb
	{
		protected var _json:Object = new Object();
		
		public function JsonDb(data:* = null) {
			this.load(data);
		}
		
		public function load(data:*):void {
			if(data) {
				if(data is String) {
					this.loadString(data);
				}else {
					this.loadObject(data);
				}
			}
		}
		
		public function loadObject(data:Object):void {
			if(data) this._json = data;
		}
		
		public function loadString(data:String):void {
			if(data) this.loadObject(JSON.parse(data));
		}
		
		public function query():JsonQuery
		{
			return new JsonQuery(this._json);
		}
	}
}