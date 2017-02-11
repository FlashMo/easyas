package com.core.db.engine.json
{
	import com.core.db.Idb;
	
	import flash.net.SharedObject;
	
	public class LocalDb extends JsonDb implements Idb
	{
		private var _local:SharedObject;
		private var _firstrun:Boolean;
		private var _name:String;
		public function LocalDb(id:String, name:String) {
			this._name = name;
			this._local = SharedObject.getLocal(id);
			var data:Object = this._local.data[this._name];
			if(!data) {
				data = new Object();
				this._firstrun = true;
			}
			this.loadObject(data);
		}
		
		public function firstrun():Boolean {
			return this._firstrun;
		}
		
		public function save():void {
			this._local.data[this._name] = this._json;
			this._local.flush();
		}
	}
}