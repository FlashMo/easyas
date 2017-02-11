package com.core.view
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Rectangle;

	public class Mview
	{
		static private var _stage:GameStage;
		static public function setStage(val:GameStage):void {
			_stage = val;	
		}
		
		static public function getStage():GameStage {
			return _stage;
		}
		
		static public function get stage():GameStage {
			return _stage;
		}
		
		static public function get content():DisplayObjectContainer {
			return _stage.content;
		}
	}
}