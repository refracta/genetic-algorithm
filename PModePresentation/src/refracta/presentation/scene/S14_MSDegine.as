/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 8:12
 */
package refracta.presentation.scene {
import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;

public class S14_MSDegine extends Scene{
	private var resource:SceneResource14;

	override public function init():void {
		resource = new SceneResource14();
		this.view.expressionMovieClip.addChild(resource);
		this.view.sceneNextChange.push(function(e:View){
			resource.removeChild(resource.flowchart);
			resource.zoom.gotoAndPlay(2);
		})
	}
}
}
