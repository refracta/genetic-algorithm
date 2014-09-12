/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 9:44
 */
package refracta.presentation.scene {
import com.greensock.TweenMax;

import flash.display.MovieClip;

import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;
import refracta.presentation.manager.PhysicalSimulatorManager;

public class S20_Physical extends Scene{
	private var resource:SceneResource20;
	private var simulator:PhysicalSimulatorManager;

	public function S20_Physical() {
		this.simulator = new PhysicalSimulatorManager(328,178,743,573);
		this.simulator.loadStart();
	}

	override public function init():void {
		resource = new SceneResource20();

		this.view.expressionMovieClip.addChild(resource);
		simulator.viewClip = new MovieClip();
		simulator.addSwf();
		this.view.expressionMovieClip.addChild(simulator.viewClip);
		TweenMax.fromTo(simulator.viewClip,4,{alpha:0},{alpha:1});
		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};
	}
}
}
