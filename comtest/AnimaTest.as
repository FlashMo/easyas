package comtest
{
	import com.core.anima.base.AnimaBase;
	import com.core.anima.base.AnimaTarget;
	import com.core.anima.clip.ClipAnima;
	import com.core.anima.clip.ClipAnimaPrototype;
	import com.core.anima.frame.FrameAnima;
	import com.core.anima.frame.FrameAnimaPrototype;
	import com.core.anima.tween.TweenAnima;
	import com.core.anima.tween.prototype.CustomTweenPrototype;
	import com.core.anima.tween.prototype.SimpleTweenPrototype;
	import com.core.anima.tween.prototype.TimelineTweenPrototype;
	import com.core.db.Mdb;
	import com.core.view.Mview;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.DisplayObjectContainer;

	public class AnimaTest
	{
		public function AnimaTest()
		{
			/*
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
			
			//setInterval(function():void {
			//	ta.clone().play(Mview.content, Math.random() * 800, Math.random()* 600);	
			//}, 200);
			
			var tm:TimeLineAnima = new TimeLineAnima();
			tm.addTween(new AnimaTarget('t1'), 2, new TweenLiteVars().x(400)).beginMultiple()
				.addTween(new AnimaTarget('t1'), 2, new TweenLiteVars().x(0))
				.addTween(new AnimaTarget('t2'), 2, new TweenLiteVars().y(400)).endMultiple();
			tm.loopOnEnd().play(Mview.content);
			*/
			
			//FrameAnima
			var fa:FrameAnima = new FrameAnima();
			fa.prototype(new FrameAnimaPrototype()
				.keyFrame(1, Mdb.swf().getBitmapData('swf/P1'))
				.keyFrame(1, Mdb.swf().getBitmapData('swf/P2'))
				.keyFrame(1, Mdb.swf().getBitmapData('swf/P3'))
				.keyFrame(1, Mdb.swf().getBitmapData('swf/P4'))
				.keyFrame(1, Mdb.swf().getBitmapData('swf/P5'))
			).autoPlay().loopOnEnd().play(Mview.content);
			fa.clone().onEnd(function(anima:AnimaBase):void {trace('123');}).hideOnEnd().pos(200, 0).play(Mview.content);
			
			//ClipAnima
			new ClipAnima(new ClipAnimaPrototype()
				.target('test', Mdb.swf().getClass('swf/ClipAnima'))
			).onEnd(function(anima:AnimaBase):void {
				//fa.clone().pos(Math.random() * 800, Math.random()* 600).play(Mview.content);
			}).loopOnEnd().pos(0, 200).play(Mview.content);	
			
			
			new TweenAnima(new CustomTweenPrototype().func( 
				function(p:DisplayObjectContainer, target:AnimaTarget):Animation {	
					return new TweenLite(target.findAt(p), 3, new TweenLiteVars().x(300).y(300));
				}
			)).loopOnEnd().play(Mview.content);
			
			new TweenAnima(new SimpleTweenPrototype()
				.time(2)
				.vars(new TweenLiteVars().x(400).y(400).scale(0.5))
			).resume(1, Mview.content);
			
			new TweenAnima(new TimelineTweenPrototype()
				.add(1, new TweenLiteVars().x(100))
				.add(2, new TweenLiteVars().x(200))
				.beginMultiple()
					.add(2, new TweenLiteVars().y(100), new AnimaTarget())
					.add(2,	new TweenLiteVars().y(200).delay(1), new AnimaTarget())
				.endMutiple()
			).onEnd(function(anima:AnimaBase):void {
				(anima as TweenAnima).pause();
			}).play(Mview.content);
		}
	}
}