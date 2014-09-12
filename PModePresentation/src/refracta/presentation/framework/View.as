package refracta.presentation.framework {
import fl.transitions.Fade;
import fl.transitions.Transition;
import fl.transitions.TransitionManager;

import flash.display.MovieClip;


public class View {
	private var _sceneNextChange:Array;
	private var _scenePrevChange:Array;
	private var _expressionMovieClip:MovieClip;
	private var _viewClip:MovieClip;
	private var _scene:Scene;
	private var _viewOutTimer:Number = 0.25;
	public static function createView(scene:Scene){
		return new View(scene);
	}
	public function get viewOutTimer():Number {
		return _viewOutTimer;
	}

	public function set viewOutTimer(value:Number):void {
		_viewOutTimer = value;
	}

	private var _viewIn:Function = function (e:View) {
		defaultFadeIn();
	};
	private var _viewOut:Function = function (e:View) {
		defaultFadeOut();
	};
	public function defaultFadeIn(){
		TransitionManager.start(viewClip, {type: Fade, direction: Transition.IN, duration: this._viewOutTimer*8});
	}
	public function defaultFadeOut(){
		TransitionManager.start(viewClip, {type: Fade, direction: Transition.OUT, duration: this._viewOutTimer});
	}


	public function get sceneNextChange():Array {
		return _sceneNextChange;
	}

	public function set sceneNextChange(value:Array):void {
		_sceneNextChange = value;
	}

	public function get scenePrevChange():Array {
		return _scenePrevChange;
	}

	public function set scenePrevChange(value:Array):void {
		_scenePrevChange = value;
	}

	public function get viewClip():MovieClip {
		return _viewClip;
	}

	public function set viewClip(value:MovieClip):void {
		_viewClip = value;
	}

	public function get expressionMovieClip():MovieClip {
		return _expressionMovieClip;
	}

	public function set expressionMovieClip(value:MovieClip):void {
		_expressionMovieClip = value;
	}


	public function get viewIn():Function {
		return _viewIn;
	}

	public function set viewIn(value:Function):void {
		_viewIn = value;
	}

	public function get viewOut():Function {
		return _viewOut;
	}

	public function set viewOut(value:Function):void {
		_viewOut = value;
	}

	public function get scene():Scene {
		return _scene;
	}

	public function set scene(value:Scene):void {
		_scene = value;
	}


	public function get currentScene():uint {
		return _currentScene;
	}

	public function set currentScene(value:uint):void {
		_currentScene = value;
	}

	private var _currentScene:uint = 0;


	public final function playViewIn() {
		this._viewIn(this);
	}

	public final function playViewOut() {
		this._viewOut(this);
	}


	public function View(scene:Scene = null) {
		this._scene = scene;
		this.viewClip = new MovieClip();

		this._scene.initScene(this);
		//

		//View Manager
		//View -> Change ->View
		//View
		//Scene init
		//Scene
		//ScenePageNextChange ->

		//AutoPrev
		//Scene init
		//ScenePageNextChange ->

		//<- ScenePagePrevChange
	}

	public final function isExistsPrev():Boolean {
		var indexCheck = this._currentScene > 0;
		return indexCheck;
	}

	public final function isExistsNext():Boolean {
		var indexCheck = this._currentScene < this._sceneNextChange.length;
		if (indexCheck == false) {
			return indexCheck;
		}
		var index = this._currentScene;
		var isExists = !(this._sceneNextChange[index] == undefined || this._sceneNextChange[index] == null);
		return isExists && indexCheck;
	}

	public final function next():Boolean {

		if (isExistsNext()) {
			this._sceneNextChange[this._currentScene](this);
			this._currentScene++;
			return true;
		} else {
			return false;
		}
		//0>1 1>2 2>3 3>4
		//0<1 1<2 2<3 3<4
		// 0   1   2   3
		// 1   3   5   7
	}

	public final function isExistsPrevChangeFunction():Boolean {
		var index = this._currentScene - 1;
		try {
			var isExists = !(this._scenePrevChange[index] == undefined || this._scenePrevChange[index] == null);
			return isExists;
		} catch (e:RangeError) {
			return false;
		}
		return false;
	}

	public final function prev():Boolean {

		if (isExistsPrev()) {
			if (isExistsPrevChangeFunction()) {
				this._scenePrevChange[this._currentScene - 1](this);
				this._currentScene--;

				return true;
			} else {
				return autoPrev();
			}
		} else {
			return false;
		}
		//0>1 1>2 2>3 3>4
		//0<1 1<2 2<3 3<4
		// 0   1   2   3
		// 1   3   5   7
	}

	private final function autoPrev():Boolean {
		if (isExistsPrev()) {
			_scene.forceInit(this);
			for (var i:int = 0; i<this._currentScene - 1; i++) {
				this._sceneNextChange[i](this);
			}
			this._currentScene--;

			return true;
		} else {
			return false
		}

	}
}
}
