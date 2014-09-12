/**
 * 개발자 : refracta
 * 날짜   : 2014-09-05 오전 7:08
 */
package refracta.presentation.view {
import com.greensock.TweenMax;

import flash.events.Event;
import flash.events.MouseEvent;

public class StartButtonWrapper extends StartButton {

	public function StartButtonWrapper() {
		registerListener();

	}

	private function registerListener():void {
		this.hitShape.addEventListener(MouseEvent.MOUSE_OVER, goTo2);
		this.hitShape.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
		this.hitShape.addEventListener(MouseEvent.MOUSE_UP, goTo1);
		this.hitShape.addEventListener(MouseEvent.MOUSE_OUT, goTo1);
	}

	function clicked(e:Event) {
		goTo3(e);
		TweenMax.to(this, 3, {alpha: 0})
		this.hitShape.removeEventListener(MouseEvent.MOUSE_OVER, goTo2);
		this.hitShape.removeEventListener(MouseEvent.MOUSE_DOWN, clicked);
		this.hitShape.removeEventListener(MouseEvent.MOUSE_UP, goTo1);
		this.hitShape.removeEventListener(MouseEvent.MOUSE_OUT, goTo1);
	}

	function goTo3(e:Event) {
		//enable if
		gotoAndPlay(3);
	}

	function goTo2(e:Event) {
		//enable if
		gotoAndStop(2);
	}

	function goTo1(e:Event) {
		//enable if
		gotoAndStop(1);
	}
}
}
