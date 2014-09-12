/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 7:15
 */
package refracta.presentation.scene {
import com.greensock.TweenMax;

import flash.display.MovieClip;

import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;
import refracta.presentation.manager.GraphSimulatorManager;

public class S13_FunctionMax extends Scene {
	private var resource:SceneResource13;
	private var simulator:GraphSimulatorManager;

	public function S13_FunctionMax() {
		this.simulator = new GraphSimulatorManager(145, 181, 382, 568);
		this.simulator.loadStart();
	}

	override public function init():void {
		resource = new SceneResource13();
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
