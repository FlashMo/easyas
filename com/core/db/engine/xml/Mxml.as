package com.core.db.engine.xml
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	public class Mxml
	{
		static public function createObject(name:*):* {
			//根据name得到Class
			var c:Class = null;
			if(name is Class){
				c = name as Class;
			}else if(name is String){
				c = getDefinitionByName(name) as Class;
			}else if(name is XML){
				var xml:XML = name as XML;
				if(xml.hasOwnProperty("@class")){
					var className:String = xml["@class"].toString();
					c = getDefinitionByName(className) as Class;
				}
			}
			
			if(c != null){
				return new c();
			}else{
				return null;
			}
		}
		
		static public function inflateByXML(xml:XML, obj:Object = null, errorCallback:Function = null):* {
			//创建对象
			if(obj == null){
				obj = Mxml.createObject(xml);
			}
			
			if(obj == null) {
				obj = new Object();
			}
			
			if(getQualifiedClassName(obj) == "Object") {
				return xml2object(xml);
			}
			
			var list:XMLList=xml.elements();
			for each(var node:XML in list){ //检查并设置属性
				var key:String = node.localName().toString();
				if(obj.hasOwnProperty(key)){
					obj[key] = node;
				}else {
					if(errorCallback != null) errorCallback(key, node);
				}
			}
			return obj;
		}
		
		static public function inflateByObject(data:Object, obj:Object, errorCallback:Function = null):Object {
			if(obj == null) throw new Error('obj can not be null!');
			
			for (var key:String in data) {
				if(obj.hasOwnProperty(key)) {
					obj[key] = data[key];
				}else {
					if(errorCallback != null) errorCallback(key, data[key]);
				}
			}
			return obj;
		}
		
		static public function xml2object(xml:XML, isArray:Boolean = false):* {
			var list:XMLList;
			if(xml.hasComplexContent() && !isArray) {
				var obj:Object = new Object();
				list = xml.elements();
				for each(var node:XML in list) { //检查并设置属性
					var key:String = node.localName().toString();
					obj[key] = node;
				}
				return obj;
			}else if(xml.hasComplexContent() && isArray){
				var arr:Array = new Array();
				list = xml.elements();
				for(var i:int = 0; i < list.length(); ++i) {
					arr.push(xml2object(list[i]));	
				}
				return arr;
			}else {
				return xml.toString();
			}
		}
		
		static public function string2object(s:String, arrFlag:*, kvFlag:*):* {
			var buf:Array;
			var i:int;
			if(arrFlag) {
				var rarr:Array = [];
				buf = s.split(arrFlag);
				for(i = 0; i < buf.length; ++i) {
					if(buf[i]) rarr.push(string2object(buf[i], null, kvFlag));
				}
				return rarr;
			}else if(kvFlag) {
				var robj:Object = new Object();
				buf = s.split(kvFlag);
				for(i = 0; i < buf.length; i+=2) {
					if(buf[i]) robj[buf[i]] = buf[i + 1];
				}
				return robj
			}else {
				return s;
			}
		}
		
		static public function xls2xml(xls:XML):XML
		{
			var buf:Array = new Array(<pxml></pxml>);
			var ns:* = xls.namespace();
			var rowList:XMLList = xls..ns::Row; //获得xls中所有的行
			var tableHead:XML = null; //当前表头
			
			for(var i:int = 0; i < rowList.length(); ++i){ //依次读取每一行
				var rowNode:XML = rowList[i];
				var cellList:XMLList = rowNode.ns::Cell.ns::Data.text(); //获取行中所有的单元格
				var cell:String = cellList[0]; //行头标志
				if(!cell){ //空白行
					continue;
				}
				
				var j:int;
				if(cell.charAt(0) == '#'){ //table
					var tableName:String;
					if(cell.substr(0, 2) == '#%'){ //注释table
						mergeBuf(buf, 1);
					}else if (cell.substr(0, 5) == '#xml:'){ //xml文本属性
						tableName = cell.substr(5);
						buf.push(<{tableName}></{tableName}>);
					}else if(cell == '#endxml') { //xml文本属性终止
						var xmlNode:XML = buf.pop();
						var pChild:XMLList = buf[buf.length - 1].elements();
						if(pChild.length()) { 
							pChild[pChild.length() - 1].appendChild(xmlNode); //将XML文本属性插入到上一条数据中
						}
					}else { //数据表
						mergeBuf(buf, 1);
						tableName = cell.substr(1);
						if(buf[0].hasOwnProperty(tableName) == false){
							buf.push(<{tableName}></{tableName}>);
						}else {
							buf.push(buf[tableName][0]);
						}
					}
				}else if(cell.charAt(0) == '$'){ //tableHead
					var className:String = cell.substr(1);
					tableHead = <head></head>;
					tableHead["@class"] = className;
					for(j = 1; j < cellList.length(); ++j){
						cell = cellList[j];
						if(!cell || cell.charAt(0) == '%'){ //空白列或注释列
							tableHead.appendChild(<comment></comment>);
						}else{
							tableHead.appendChild(<{cell}></{cell}>);
						}
					}
					
				}else if(cell.charAt(0) == '%'){ //注释行
					continue;
				}else{ //数据行 （待优化，将数据行也push到buf中的方式与table和xml文本属性操作相统一）
					if(buf.length > 1 && tableHead){
						var entity:XML = tableHead.copy();
						entity.setLocalName(cell);
						var list:XMLList = entity.elements();
						for(j = 0; j < list.length(); ++j){
							if(list[j].localName() == 'comment'){ //注释列（待优化以去除数据的comment属性）
								continue;
							}else{
								cell = cellList[j + 1];
								if(!cell || cell.charAt(0) == '%'){ //空白格或注释格
									continue;
								}else{ //数据格
									list[j].text()[0] = cell;
								}
							}
						}
						for(j = 0; j < list.length(); ++j) {
							if(list[j].localName() == 'comment') {
								delete list[j];
								--j;
							}
						}
						
						buf[buf.length - 1].appendChild(entity);
					}
				}
			}
			mergeBuf(buf, 1);
			return buf[0];
		}
		
		static private function mergeBuf(buf:Array, size:int):void
		{
			while(buf.length > size) {
				var child:XML = buf.pop();
				var p:XML = buf[buf.length - 1];
				p.appendChild(child);
			}
		}
	}
}