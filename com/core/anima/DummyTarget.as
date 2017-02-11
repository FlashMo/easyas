package com.core.anima
{
	import flash.display.MovieClip;
	
	public class DummyTarget extends MovieClip
	{
		public function DummyTarget()
		{
			this.graphics.beginFill(0x00ff00);
			this.graphics.drawRect(0, 0, 100, 100);
			this.graphics.endFill();
		}
	}
}