/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 2:57
 */
package refracta.presentation.scene {
import flash.display.MovieClip;

import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;

public class $0_DefaultScene extends Scene {
	private var resource:MovieClip;

	public function $0_DefaultScene(resource:MovieClip) {
		this.resource = resource;
	}

	override public function init():void {
		this.view.expressionMovieClip.addChild(resource);
		resource.gotoAndPlay(1);
		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};
	}
}
}
