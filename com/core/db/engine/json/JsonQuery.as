package com.core.db.engine.json
{
	public class JsonQuery
	{
		private var _obj:Object;
		public function JsonQuery(obj:Object) {
			this._obj = obj;	
		}
		//------------ 定位 ---------------------
		public function key(k:String):JsonQuery {
			this._obj = this._obj[k];
			return this;
		}
		
		public function itemByIndex(index:int):JsonQuery {
			this._obj = this._obj[index];
			return this;
		}
		
		public function itemByKey(k:String, v:*):JsonQuery {
			var arr:Array = this.list();
			for(var i:int = 0; i < arr.length; ++i) {
				if(arr[i][k] == v) {
					this._obj = arr[i];
					return this;
				}
			}
			this._obj = null;
			return this;
		}
		
		//------------ 取值 -------------------
		public function val():* {
			return this._obj;	
		}
		
		public function list():Array {
			return this._obj as Array;
		}
		
		public function keyVal(k:String):* {
			return this._obj[k];
		}
		
		public function itemValByIndex(index:int):JsonQuery {
			return this._obj[index];
		}
		
		//----------- 修改 --------------------
		public function setKey(k:String, val:*):JsonQuery {
			this._obj[k] = val;	
			return this;
		}
		
		public function setItemByIndex(index:int, val:*):JsonQuery {
			this.list()[index] = val;
			return this;
		}
	}
}