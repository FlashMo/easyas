package com.core.anima.base
{
	import flash.display.DisplayObjectContainer;

	public interface IEffect
	{
		function play(p:DisplayObjectContainer, px:Number = 0, py:Number = 0):void;
		function stop(clean:Boolean = true):void;
		function get playing():Boolean;
	}
}