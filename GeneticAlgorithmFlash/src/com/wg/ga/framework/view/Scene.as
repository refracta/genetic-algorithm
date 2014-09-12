/**
 * 개발자 : refracta
 * 날짜   : 14. 8. 8 오전 9:32
 */
package com.wg.ga.framework.view {
import flash.display.MovieClip;
import flash.events.Event;

public class Scene {
	private var _view:View;

	public function get view():View {
		return _view;
	}

	public final function initScene(view:View) {
		this._view = view;

		this._view.sceneNextChange = new Array();
		this._view.scenePrevChange = new Array();
		if (this._view.expressionMovieClip != null || this._view.expressionMovieClip != undefined) {
			this._view.viewClip.removeChild(this._view.expressionMovieClip);
		}
		if (this._view.expressionMovieClip != null || this._view.expressionMovieClip != undefined)
		{
			for(var i:int = 0 ; i < this._view.expressionMovieClip.numChildren; i++){
				this._view.expressionMovieClip.removeChildAt(i);
			}
		}
		this._view.expressionMovieClip = new MovieClip();
		this._view.viewClip.addChild(this._view.expressionMovieClip);
		this._view.expressionMovieClip.addEventListener(Event.RENDER, rendnerMovieClip)
//		init();
	}

	public function rendnerMovieClip(e:Event) {
		init();
		this._view.expressionMovieClip.removeEventListener(Event.RENDER, rendnerMovieClip);
	}
	public function forceInit(view:View){
		initScene(view);
		rendnerMovieClip(null);
	}

	public function init():void {
	}
}
}
