/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 3:53
 */
package refracta.presentation.scene {
import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;

public class S5_PlayAlgorithm extends Scene{
	private var resource:SceneResource5;
	override public function init():void {
		resource = new SceneResource5();
		this.view.expressionMovieClip.addChild(resource);
		this.view.sceneNextChange.push(function(e:View){
			resource.flaMovie.gotoAndPlay(2);
		})
	}
}
}
