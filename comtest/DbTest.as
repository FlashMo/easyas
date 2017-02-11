package comtest
{
	import com.core.db.Mdb;
	import com.core.db.loader.MultiLoader;
	import com.core.view.Mview;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;

	public class DbTest extends EventDispatcher
	{
		public function DbTest()
		{
			var l:MultiLoader = new MultiLoader();
			l.addURLLoader('json', 'comtest/assets/test.json');
			l.addURLLoader('xml', 'comtest/assets/values.xml');
			l.addLoader('swf', 'comtest/assets/swf.swf');
			l.addEventListener(Event.COMPLETE, onLoadComplete);
			l.start();
		}
		
		private function onLoadComplete(e:Event):void {
			trace('DbTest');
			var l:MultiLoader = e.target as MultiLoader;
			trace('ObjectDb');
			Mdb.addObjectDb();
			Mdb.object().setVal('name', 'mcj');
			trace(Mdb.object().getVal('name'));
			
			trace('JsonDb');
			Mdb.addJsonDb(l.getStringData('json'));
			trace(Mdb.json().query().key('name').val());
			trace(Mdb.json().query().key('list').itemByKey('id', 2).keyVal('name'));
			trace(Mdb.json().query().key('list').itemByIndex(1).keyVal('name'));
			
			trace('LocalDb');
			Mdb.addLocalDb('pygame.asframework');
			if(Mdb.local().firstrun()) {
				trace('firstrun');
				Mdb.local().query().setKey('times', 1);
				Mdb.local().save();
			}else {
				var times:int = Mdb.local().query().keyVal('times');
				trace(times++);
				Mdb.local().query().setKey('times', times);
			}
			
			trace('XmlDb');			
			Mdb.addXmlDb(l.getXMLData('xml'));
			trace(Mdb.xml().query().key('map').val());
			trace(Mdb.xml().query().key('battler').keyVal('小战士'));
			
			trace('SwfDb');
			Mdb.addSwfDb();
			Mdb.swf().loadSwf('swf', l.getSwfData('swf'));
			var sound:Sound = Mdb.swf().getSound('swf/Wave');
			//sound.play();
			var clip:MovieClip = Mdb.swf().getMovieClip('swf/Anima');
			Mview.content.addChild(clip);
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}