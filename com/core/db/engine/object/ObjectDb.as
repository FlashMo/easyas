package com.core.db.engine.object
{
	import com.core.db.Idb;
	import com.core.db.engine.json.JsonQuery;
	
	public class ObjectDb implements Idb
	{
		private var _map:Object = new Object();
		
		public function ObjectDb(map:Object = null) {
			this.load(map);
		}
		
		public function load(map:Object):void {
			if(map) this._map = map;
		}
		
		public function getVal(key:String):* {
			return this._map[key];
		}
		
		public function setVal(key:String, val:*):void {
			this._map[key] = val;
		}
		
		public function query():JsonQuery {
			return new JsonQuery(this._map);
		}
	}
}