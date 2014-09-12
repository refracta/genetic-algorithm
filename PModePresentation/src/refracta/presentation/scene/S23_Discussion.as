/**
 * 개발자 : refracta
 * 날짜   : 2014-09-07 오전 2:24
 */
package refracta.presentation.scene {
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;

public class S23_Discussion extends Scene {
	private var resource:SceneResource23;

	override public function init():void {
		resource = new SceneResource23();
		this.view.expressionMovieClip.addChild(resource);
		resource.text1.alpha = 0;
		resource.text2.alpha = 0;
		resource.text3.alpha = 0;
		resource.text4.alpha = 0;
		this.view.sceneNextChange.push(function (e:View) {
			TweenMax.fromTo(resource.text1, 1,
					{
						alpha: 0, x: -1366
					},
					{
						x: 65,
						alpha: 1,
						ease: Sine.easeInOut
					});
		});
		this.view.sceneNextChange.push(function (e:View) {
			TweenMax.fromTo(resource.text2, 1,
					{
						alpha: 0, x: 1366
					},
					{
						x: 65,
						alpha: 1,
						ease: Sine.easeInOut
					});
		});
		this.view.sceneNextChange.push(function (e:View) {
			TweenMax.fromTo(resource.text3, 1,
					{
						alpha: 0, x: -1366
					},
					{
						x: 65,
						alpha: 1,
						ease: Sine.easeInOut
					});
		});
		this.view.sceneNextChange.push(function (e:View) {
			TweenMax.fromTo(resource.text4, 1,
					{
						alpha: 0, x: -1366
					},
					{
						x: 65,
						alpha: 1,
						ease: Sine.easeInOut
					});

		});

	}

}
}
