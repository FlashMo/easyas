package com.core.db
{
	import com.core.db.engine.json.JsonDb;
	import com.core.db.engine.json.LocalDb;
	import com.core.db.engine.object.ObjectDb;
	import com.core.db.engine.swf.SwfDb;
	import com.core.db.engine.xml.Mxml;
	import com.core.db.engine.xml.XmlDb;
	
	import flash.system.ApplicationDomain;

	public class Mdb
	{
		static private var _map:Object = new Object();	
		
		static public function addLocalDb(id:String, name:String = '__local'):void {
			var db:LocalDb = new LocalDb(id, name);
			addDb(name, db);
		}
		
		/**
		 * 获得本地存储数据库
		 * */
		static public function local(name:String = '__local'):LocalDb {
			return getDb(name) as LocalDb;	
		}
		
		static public function addSwfDb(name:String = '__swf'):void {
			var db:SwfDb = new SwfDb();
			addDb(name, db);
		}
		
		/**
		 * 获得swf数据库
		 * */
		static public function swf(name:String = '__swf'):SwfDb {
			return getDb(name) as SwfDb;	
		}			
		
		static public function addXmlDb(data:XML, name:String = '__xml'):void {
			var db:XmlDb = new XmlDb(data);
			addDb(name, db);
		}
		
		/**
		 * 获得xml数据库
		 * */
		static public function xml(name:String = '__xml'):XmlDb {
			return getDb(name) as XmlDb;
		}
		
		static public function addJsonDb(data:*, name:String = '__json'):void {
			var db:JsonDb = new JsonDb(data);	
			addDb(name, db);
		}
		
		/**
		 * 获得json数据库
		 * */
		static public function json(name:String = '__json'):JsonDb {
			return getDb(name) as JsonDb;
		}
		
		static public function addObjectDb(data:Object = null, name:String = '__object'):void {
			var db:ObjectDb = new ObjectDb(data);
			addDb(name, db);	
		}
		
		/**
		 * 获得Object数据库
		 * */
		static public function object(name:String = '__object'):ObjectDb {
			var db:Idb = getDb(name);
			return db as ObjectDb;
		}
		
		static public function addDb(name:String, db:Idb):void {
			_map[name] = db;
		}
		
		static public function getDb(name:String):Idb {
			return _map[name];
		}
	}
}