package com.core.anima.tween.builder
{
	import com.greensock.TimelineLite;
	import com.greensock.core.Animation;
	
	import flash.display.DisplayObjectContainer;

	public interface ITweenBuilder
	{
		function genAnima(p:DisplayObjectContainer, factory:Function = null):Animation;
		function append2TimeLine(timeline:TimelineLite, p:DisplayObjectContainer, factory:Function = null):void;
	}
}