/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 1:29
 */
package refracta.presentation.scene {
import com.greensock.TweenMax;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.setTimeout;

import refracta.presentation.framework.PresentationManager;
import refracta.presentation.framework.Scene;
import refracta.presentation.framework.View;
import refracta.presentation.manager.LogoManager;
import refracta.presentation.starter.Main;
import refracta.presentation.view.StartButtonWrapper;

public class S1_StartScene extends Scene {
	private var _startButton:StartButtonWrapper;
	private var _logoManager:LogoManager;
	private var presentationManager:PresentationManager;
	private var main:Main;
	public function S1_StartScene(main:Main) {
		_logoManager = new LogoManager();
		_logoManager.loadStart();
		this.presentationManager = main.presentationManager;
		this.main = main;
	}

	public function get startButton():StartButtonWrapper {
		return _startButton;
	}

	public function set startButton(value:StartButtonWrapper):void {
		_startButton = value;
	}

	public function get logoManager():LogoManager {
		return _logoManager;
	}

	public function set logoManager(value:LogoManager):void {
		_logoManager = value;
	}

	override public function init():void {
		this.main.keyBoardLock = true;
		this._startButton = new StartButtonWrapper();
		function mouseDownHandler(e:Event) {
			function enterFrameAdd(e:Event) {
				trace(logoManager.isLoaded);
				if (logoManager.isLoaded) {
					logoManager.viewClip = new MovieClip();
					logoManager.addSwf();
					view.expressionMovieClip.addChild(logoManager.viewClip);
					TweenMax.fromTo(logoManager.viewClip, 3, {alpha: 0}, {alpha: 1});
					view.expressionMovieClip.removeEventListener(Event.ENTER_FRAME, enterFrameAdd);

				}

			}

			setTimeout(function () {
				presentationManager.nextPresentation();
				main.keyBoardLock = false;
				trace("Logo End Next Presentation")
			}, 1000 * 8);
			view.expressionMovieClip.addEventListener(Event.ENTER_FRAME, enterFrameAdd);
		}
		this._startButton.hitShape.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		this.view.expressionMovieClip.addChild(this._startButton);
		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};
	}


}
}
