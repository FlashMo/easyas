package comtest
{
	import com.core.db.Mdb;
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.base.IAnima;
	import com.core.anima.clip.ClipAnima;
	import com.core.anima.frame.FrameAnima;
	import com.core.anima.tween.TimeLineAnima;
	import com.core.anima.tween.TweenAnima;
	import com.core.view.Mview;
	import com.greensock.TweenAlign;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.Back;
	import com.greensock.easing.Expo;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

	public class AnimaTest
	{
		public function AnimaTest()
		{
			//启用autoalpha插件
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			var fa:FrameAnima = new FrameAnima();
			fa.keyFrame(1, Mdb.swf().getBitmapData('swf/P1'));
			fa.keyFrame(1, Mdb.swf().getBitmapData('swf/P2'));
			fa.keyFrame(1, Mdb.swf().getBitmapData('swf/P3'));
			fa.keyFrame(1, Mdb.swf().getBitmapData('swf/P4'));
			fa.keyFrame(1, Mdb.swf().getBitmapData('swf/P5'));
			//fa.frame(99);
			var tmp:FrameAnima = fa.clone() as FrameAnima;
			tmp.autoPlay().loopOnEnd().play(Mview.content);
			
			var ca:ClipAnima = new ClipAnima();
			ca.setTarget('test', Mdb.swf().getClass('swf/ClipAnima'));
			ca.clipByLabel('go', 'back').removeOnEnd();
			ca.clone().play(Mview.content, 0, 200);
			
			var ca2:ClipAnima = new ClipAnima();
			ca2.setTarget('', Mdb.swf().getClass('swf/ClipAnima'));
			ca2.loopOnEnd();
			var tmp2:IAnima = ca2.clone();
			tmp2.play(Mview.content, 0, 400);
			
			var ta:TweenAnima = new TweenAnima();
			ta.time(2).vars.scale(2).prop('alpha', 0.5).ease(Expo.easeOut);
			ta.loopOnEnd();
			ta.play(Mview.content, 300, 300);
			/*
			setInterval(function():void {
				ta.clone().play(Mview.content, Math.random() * 800, Math.random()* 600);	
			}, 200);
			*/
			
			var tm:TimeLineAnima = new TimeLineAnima();
			tm.addTween(new AnimaTarget('t1'), 2, new TweenLiteVars().x(400)).beginMultiple()
				.addTween(new AnimaTarget('t1'), 2, new TweenLiteVars().x(0))
				.addTween(new AnimaTarget('t2'), 2, new TweenLiteVars().y(400)).endMultiple();
			tm.loopOnEnd().play(Mview.content);
		}
	}
}