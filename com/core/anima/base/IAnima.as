package com.core.anima.base
{
	import flash.geom.Point;

	public interface IAnima extends IEffect
	{
		function clone():IAnima;
		function update(delta:Number = 1):void;
	}
}