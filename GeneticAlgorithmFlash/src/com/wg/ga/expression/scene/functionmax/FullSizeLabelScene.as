/**
 * 개발자 : refracta
 * 날짜   : 2014-08-13 오전 4:24
 */
package com.wg.ga.expression.scene.functionmax {
import com.refracta.view.FullScreenLabel;
import com.wg.ga.framework.view.Scene;

public class FullSizeLabelScene extends Scene{
	private var screenLabel:FullScreenLabel;
	private var labelText:String;

	public function FullSizeLabelScene(labelText:String) {
		this.labelText = labelText;
	}

	override public function init():void {
		screenLabel = new FullScreenLabel();
		screenLabel.setText(this.labelText);
		this.view.expressionMovieClip.addChild(screenLabel);
	}
}
}
