/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오후 10:12
 */
package refracta.presentation.scene {
import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;
import refracta.presentation.pconst.PresentationConst;

public class S21_PhysicalMovie extends Scene{

	private var resource:SceneResource21;

	override public function init():void {
		resource = new SceneResource21();
		resource.physical.source = "resources/movie/physical.flv";
		this.view.expressionMovieClip.addChild(resource);

	}
}
}
