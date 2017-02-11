package comtest
{
	import com.core.db.Mdb;
	import com.core.view.GamePage;
	import com.core.view.GameStage;
	import com.core.view.Mview;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ViewTest
	{
		private var _p1:GamePage;
		private var _p2:GamePage;
		public function ViewTest()
		{
			this._p1 = new GamePage();
			this._p1.skin = Mdb.swf().getMovieClip('swf/Layer');
			this._p1.query().textFieldVal('label').text = 'P1';
			this._p1.query().key('label').top();
			this._p1.addEventListener(MouseEvent.CLICK, onPageClick);			
			
			this._p2 = new GamePage();
			this._p2.skin = Mdb.swf().getMovieClip('swf/Layer');
			this._p2.query().textFieldVal('label').text = 'P2';
			this._p2.query().key('label').container(this._p2).center().middle();
			this._p2.addEventListener(MouseEvent.CLICK, onPageClick);
			
			this._p1.start();
		}
		
		private function onPageClick(e:Event):void {
			if(e.currentTarget == this._p1) {
				this._p1.end();
				this._p2.start();
			}else {
				this._p2.end();
				this._p1.start();
			}
		}
	}
}