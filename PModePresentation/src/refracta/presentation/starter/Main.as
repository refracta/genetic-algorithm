package refracta.presentation.starter {

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.media.Video;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.ui.Keyboard;
import flash.utils.setInterval;
import flash.utils.setTimeout;

import refracta.presentation.framework.PresentationManager;
import refracta.presentation.framework.Scene;

import refracta.presentation.manager.LogoManager;
import refracta.presentation.manager.VideoSkinManager;
import refracta.presentation.pconst.PresentationConst;
import refracta.presentation.scene.*;


import refracta.presentation.scene.S5_PlayAlgorithm;

import refracta.presentation.scene.S7_Darwin;


[SWF(backgroundColor="#DDE0E0", width=1366, height=768, frameRate='60')]
public class Main extends Sprite {
	private var _presentationManager:PresentationManager;
	private var _keyBoardLock:Boolean = false;

	public function get presentationManager():PresentationManager {
		return _presentationManager;
	}

	public function get keyBoardLock():Boolean {
		return _keyBoardLock;
	}

	public function set keyBoardLock(value:Boolean):void {
		_keyBoardLock = value;
	}

	public function initView() {
		var s1:S1_StartScene = new S1_StartScene(this);
		var s2:$0_DefaultScene = new $0_DefaultScene(new SceneResource2());
		var s3:S3_Algorithm = new S3_Algorithm();
		var s4:$0_DefaultScene = new $0_DefaultScene(new SceneResource4());
		var s5:S5_PlayAlgorithm = new S5_PlayAlgorithm();
		var s6:$0_DefaultScene = new $0_DefaultScene(new SceneResource6());
		var s7:S7_Darwin = new S7_Darwin();
		var s8:$0_DefaultScene = new $0_DefaultScene(new SceneResource8());
		var s9:$0_DefaultScene = new $0_DefaultScene(new SceneResource9());
		var s10:$0_DefaultScene = new $0_DefaultScene(new SceneResource10());
		var s11:$0_DefaultScene = new $0_DefaultScene(new SceneResource11());
		var s12:$0_DefaultScene = new $0_DefaultScene(new SceneResource12());
		var s13:S13_FunctionMax = new S13_FunctionMax();
		var s14:S14_MSDegine = new S14_MSDegine();
		var s15:S15_MissileMovie = new S15_MissileMovie();
		var s16:$0_DefaultScene = new $0_DefaultScene(new SceneResource16());
		var s17:$0_DefaultScene = new $0_DefaultScene(new SceneResource17());
		var s18:$0_DefaultScene = new $0_DefaultScene(new SceneResource18());
		var s19:S19_AirResistance = new S19_AirResistance();
		var s20:S20_Physical = new S20_Physical();
		var s21:S21_PhysicalMovie = new S21_PhysicalMovie();
		var s22:S22_TspMovie = new S22_TspMovie();
		var s23:S23_Discussion = new S23_Discussion();
		var s24:S24_Conclusion = new S24_Conclusion();
		var s25:$0_DefaultScene = new $0_DefaultScene(new SceneResource25());

		var scenes:Vector.<Scene> = new <Scene>
				[s1, s2 , s3, s4, s5 , s6 , s7 , s8 , s9 , s10 , s11, s12, s13 , s14, s15 , s16, s17, s18, s19, s20 , s21, s22 , s23, s24, s25];
		scenes.forEach(function (element) {
			_presentationManager.addSceneView(element);
		});
		//registerScene
	}
	private var isLiveCheckLoader:URLLoader = new URLLoader();
	public function Main() {
		this._presentationManager = new PresentationManager();
		initEvent();

		isLiveCheckLoader.addEventListener(Event.COMPLETE, completeCheck);
		isLiveCheckLoader.addEventListener(IOErrorEvent.IO_ERROR, checkError);
		isLiveCheckLoader.load(new URLRequest(PresentationConst.DEFAULT_URL+"check.txt"+"?time=" + Number(new Date().getTime())));
	}
	private function completeCheck(event:Event):void {
		var dataStr:String = String(isLiveCheckLoader.data);
		trace("DATA : "+dataStr);
		switch (dataStr){
			case "USE_THIS_SERVER":
					trace("→USE_THIS_SERVER");
				break;
			case "NOT_USE_THIS_SERVER":
				PresentationConst.setURL("http://null.abstr.net/ga/ppt/");
				trace("→NOT_USER_THIS_SERVER");
				break;
			default :
				PresentationConst.setURL("http://null.abstr.net/ga/ppt/");
				trace("→DEFAULT_NOT_USE");
				break;
		}
		start();
	}
	private function checkError(event:IOErrorEvent):void {
		PresentationConst.setURL("http://null.abstr.net/ga/ppt/");
		trace("CHECK_ERROR");
		start();
	}
	public function start(){
		if (!PresentationConst.VIDEO_SKIN_FILE_CACHE_LOCATION.exists) {
			new VideoSkinManager().loadStart();
		}
		allInit();
	}
	function allInit() {
		initView();
		_presentationManager.start();
		addChild(_presentationManager.presentationViewClip);
	}


	function keyBoardEvent(e:KeyboardEvent) {
		if (!_keyBoardLock) {
			if (e.keyCode == Keyboard.PAGE_DOWN) {
				trace("NEXT PRESENTATION : " + _presentationManager.nextPresentation())
			} else if (e.keyCode == Keyboard.PAGE_UP) {
				trace("PREV PRESENTATION : " + _presentationManager.prevPresentation());
			}
		}
	}

	public function initEvent() {

		var updateStage:Function = function (e:Event) {
			if (stage != null) {
				stage.invalidate();
			}
		};
		var stageEventFunctionInit:Function = function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, stageEventFunctionInit);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardEvent);
			stage.addEventListener(Event.ENTER_FRAME, updateStage);
		};
		this.addEventListener(Event.ADDED_TO_STAGE, stageEventFunctionInit);
	}


}
}
