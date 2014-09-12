/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 3:28
 */
package refracta.presentation.scene {
import flash.display.MovieClip;

import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;

public class S3_Algorithm extends Scene{

	private var resource:SceneResource3;

	override public function init():void {
		resource = new SceneResource3();
		this.view.expressionMovieClip.addChild(resource);
		this.view.sceneNextChange.push(function(e:View){
			resource.zoom.gotoAndPlay(2);

		})
	}
}
}
