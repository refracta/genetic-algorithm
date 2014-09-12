/**
 * 개발자 : refracta
 * 날짜   : 2014-09-07 오전 1:41
 */
package refracta.presentation.scene {
import refracta.presentation.framework.Scene;
import refracta.presentation.pconst.PresentationConst;

public class S22_TspMovie extends Scene{
	private var resource:SceneResource22;

	override public function init():void {
		resource = new SceneResource22();
		resource.tsp_movie.source = "resources/movie/tsp_simulator.flv";
		this.view.expressionMovieClip.addChild(resource);
	}
}
}
