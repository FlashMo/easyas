package com.core.db.engine.xml
{
	import com.core.db.Idb;
	
	public class XmlDb implements Idb
	{
		private var _xml:XML = <db></db>;
		public function XmlDb(data:XML) {
			this.load(data);
		}
		
		public function load(data:XML):void {
			if(data) {
				if(data.localName() == 'Workbook') { //xls 
					this.loadXls(data);
				}else { //xml
					this.loadXml(data);
				}
			}
		}
		
		public function loadXml(xml:XML):void {
			this._xml = xml;		
		}
		
		public function loadXls(xls:XML):void {
			var xml:XML = Mxml.xls2xml(xls);
			loadXml(xml);
		}
		
		public function query():XmlQuery {
			return new XmlQuery(this._xml);
		}
	}
}