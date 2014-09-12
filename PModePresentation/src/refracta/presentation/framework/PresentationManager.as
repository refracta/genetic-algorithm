/**
 * 개발자 : refracta
 * 날짜   : 14. 8. 8 오전 9:22
 */
package refracta.presentation.framework {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class PresentationManager {
	private var _presentationViews:Vector.<View>;
	private var _currentView:uint = 0;
	private var _presentationViewClip:MovieClip;

	public function addSceneView(scene:Scene){
		addView(View.createView(scene));
	}
	public function addView(view:View){
		this.presentationViews.push(view);
	}

	public function start() {

		this._presentationViewClip.addChild(_presentationViews[_currentView].viewClip);

	}

	public function get currentView():uint {
		return _currentView;
	}

	public function set currentView(value:uint):void {
		_currentView = value;
	}

	public function get presentationViewClip():MovieClip {
		return _presentationViewClip;
	}

	public function set presentationViewClip(value:MovieClip):void {
		_presentationViewClip = value;
	}


	public function PresentationManager() {
		this._presentationViews = new Vector.<View>();
		this._presentationViewClip = new MovieClip();
	}

	public final function getCurrentView():View {
		return this._presentationViews[this._currentView];
	}

	public function nextView():Boolean {
		if (isExistsNextView()) {
			this._presentationViews[this._currentView].viewOut(this._presentationViews[this._currentView]);
			var timer:Timer = new Timer(this._presentationViews[this._currentView].viewOutTimer * 1000, -1);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			var currentViewCache:int = this._currentView;
			function timerHandler(evt:Event):void {
				_presentationViewClip.removeChild(_presentationViews[currentViewCache].viewClip);
				_presentationViewClip.addChild(_presentationViews[currentViewCache + 1].viewClip);
				_presentationViews[currentViewCache + 1].viewIn(_presentationViews[currentViewCache + 1]);
			}
			this._currentView++;

			return true;
		} else {
			return false;
		}
	}

	public function isExistsNextView():Boolean {
		var indexCheck:Boolean = this._currentView + 1< this._presentationViews.length;
		if (indexCheck == false) {
			return indexCheck;
		}
		var index:int = this._currentView + 1;
		var isExists:Boolean = !(this._presentationViews[index] == null || this._presentationViews[index] == undefined);
		return isExists && indexCheck;
	}
	public function isExistsView(index:uint):Boolean {
		var indexCheck:Boolean = index < this._presentationViews.length && index > -1;
		return indexCheck;
	}

	public function isExistsPrevView():Boolean {
		var indexCheck:Boolean = this._currentView > 0;
		if (indexCheck == false) {
			return indexCheck;
		}
		var index:int = this._currentView - 1;
		var isExists:Boolean = !(this._presentationViews[index] == null || this._presentationViews[index] == undefined);
		return isExists && indexCheck;
	}
	public function moveView(index:uint):Boolean{
		if(isExistsView(index)){
			if(index>this._currentView){
//				this.getCurrentView().currentScene = this.getCurrentView().sceneNextChange.length-1;
				while(this.getCurrentView().next());
			}else if(index<this._currentView){
//				this.getCurrentView().currentScene = 0;
				while(this.getCurrentView().prev());
			}
			this._presentationViews[this._currentView].viewOut(this._presentationViews[this._currentView]);
			var timer:Timer = new Timer(this._presentationViews[this._currentView].viewOutTimer * 1000, -1);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			var currentViewCache:int = this._currentView;
			function timerHandler(evt:Event):void {
				_presentationViewClip.removeChild(_presentationViews[currentViewCache].viewClip);
				_presentationViewClip.addChild(_presentationViews[index].viewClip);
				_presentationViews[index].viewIn(_presentationViews[index]);
			}
			this._currentView = index;
			return true;
		}else{
			return false;
		}
	}

	public function prevView():Boolean {
		if (isExistsPrevView()) {
			this._presentationViews[this._currentView].viewOut(this._presentationViews[this._currentView]);
			var timer:Timer = new Timer(this._presentationViews[this._currentView].viewOutTimer * 1000, -1);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			var currentViewCache:int = this._currentView;
			function timerHandler(evt:Event):void {
				_presentationViewClip.removeChild(_presentationViews[currentViewCache].viewClip);
				_presentationViewClip.addChild(_presentationViews[currentViewCache -1].viewClip);
				_presentationViews[currentViewCache -1].viewIn(_presentationViews[currentViewCache -1]);
			}
			this._currentView--;
			return true;
		} else {
			return false;
		}
	}

	public function nextPresentation():Boolean {
		if (getCurrentView().isExistsNext()) {
			return getCurrentView().next();
		} else {
			if (isExistsNextView()) {
				return nextView();
			} else {
				return false;
			}
		}
		return false;
	}

	public function prevPresentation():Boolean {
		if (getCurrentView().isExistsPrev()) {
			return getCurrentView().prev();
		} else {
			if (isExistsPrevView()) {
				return prevView();
			} else {
				return false;
			}
		}
		return false;
	}

	public function get presentationViews():Vector.<View> {
		return _presentationViews;
	}

	public function set presentationViews(value:Vector.<View>):void {
		_presentationViews = value;
	}
}
}
