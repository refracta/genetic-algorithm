/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 5:24
 */
package refracta.presentation.scene {
import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;

public class S7_Darwin extends Scene {
	private var resource:SceneResource7;

	override public function init():void {
		resource = new SceneResource7();
		this.view.expressionMovieClip.addChild(resource);
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(60 + 1);
		});
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(80 + 1);
		});
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(110 + 1);
		});
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(130 + 1);
		});
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(150 + 1);
		});
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(170 + 1);
		});
		this.view.sceneNextChange.push(function (e:View) {
			resource.tweenRabbit.gotoAndPlay(190 + 1);
		});
	}
}
}
