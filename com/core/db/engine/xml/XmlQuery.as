package com.core.db.engine.xml
{
	public class XmlQuery
	{
		private var _xml:XML;
		public function XmlQuery(xml:XML) {
			this._xml = xml;
		}
		
		//----------- 定位 --------------
		public function key(k:String):XmlQuery {
			this._xml = this._xml[k][0];
			return this;
		}
		
		//------------ 取值 --------------
		public function keyVal(k:String):XML {
			return this._xml[k][0];
		}
		
		public function val():XML {
			return this._xml;
		}
		
		public function list():XMLList {
			return this._xml.elements();
		}
	}
}