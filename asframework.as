package
{
	import com.core.view.GameStage;
	import com.core.view.Mview;
	
	import comtest.AnimaTest;
	import comtest.DbTest;
	import comtest.ViewTest;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(frameRate="60",width="800",height="600",backgroundColor="0xffffff")] 
	public class asframework extends GameStage
	{
		public function asframework()
		{			
			this.setSize(800, 600);
			this.drawBackground(0x000000);
			Mview.setStage(this);
			new DbTest().addEventListener(Event.COMPLETE, this.onDbComplete);
		}
		
		private function onDbComplete(e:Event):void {
			//new ViewTest();
			
			
			new AnimaTest();
		}
	}
}