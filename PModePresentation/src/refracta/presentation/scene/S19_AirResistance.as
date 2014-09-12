/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 11:59
 */
package refracta.presentation.scene {
import com.greensock.TweenMax;

import flash.display.MovieClip;

import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;


public class S19_AirResistance extends Scene {
	private var resource:SceneResource19;

	public function S19_AirResistance() {

	}

	override public function init():void {
		resource = new SceneResource19();
		this.view.expressionMovieClip.addChild(resource);
		this.view.sceneNextChange.push(function (e:View) {
			TweenMax.fromTo(resource.air, 1, {alpha: 0}, {alpha: 1, y: 236});
			resource.air.gotoAndPlay(1);
		});
		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};
	}
}
}
