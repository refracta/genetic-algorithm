/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오후 10:06
 */
package refracta.presentation.scene {
import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;
import refracta.presentation.pconst.PresentationConst;

public class S15_MissileMovie extends Scene{
	private var resource:SceneResource15;

	override public function init():void {
		resource = new SceneResource15();
		resource.missileAI.source = "resources/movie/missileAI.flv";
		resource.missileGA.source = "resources/movie/missileGA.flv";
		this.view.expressionMovieClip.addChild(resource);

	}
}
}
