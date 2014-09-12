package com.wg.ga.starter.presentation {
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.wg.ga.framework.view.PresentationManager;
import com.wg.ga.framework.view.View;

import flash.display.MovieClip;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import com.refracta.view.smode.*;
[SWF(backgroundColor="#DDE0E0", width="1366", height="768", frameRate='60')]
public class SMode extends MovieClip {
	private var presentationManager:PresentationManager;


	public function SMode() {

		this.presentationManager = new PresentationManager();
		var ppt:Vector.<MovieClip> = new Vector.<MovieClip>();
		//ppt.push(new AllInOne())
		ppt.push(new S1());
		ppt.push(new S2());
		ppt.push(new S2_5());
		ppt.push(new S3());
		ppt.push(new S4());
		ppt.push(new S5());
		ppt.push(new S6());
		ppt.push(new S7());
		ppt.push(new S8());
		ppt.push(new S9());
		ppt.push(new S10());
		ppt.push(new S11());
		ppt.push(new S12());
		ppt.push(new S13());
		ppt.push(new S14());
		ppt.push(new S15());
		for(var i:int = 0; i < ppt.length; i++){
			this.presentationManager.addSceneView(new PresentationScene(ppt[i]));
		}


		this.presentationManager.start();
		addChild(presentationManager.presentationViewClip);

		initEvent();
	}

	public function initEvent() {
		TweenMax.killAll(true, true, true, true);
		var keyBoardEvent:Function = function (e:KeyboardEvent) {
			if (e.keyCode == Keyboard.RIGHT) {
				trace("NEXT PRESENTATION : " + presentationManager.nextPresentation())
			} else if (e.keyCode == Keyboard.LEFT) {
				trace("PREV PRESENTATION : " + presentationManager.prevPresentation());
			}
		};
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

import com.greensock.TweenMax;
import com.greensock.easing.Cubic;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;

import flash.display.MovieClip;



import flash.text.TextField;

class PresentationScene extends Scene {
	private var sComponent:MovieClip;

	public function PresentationScene(sComponent:MovieClip) {
		this.sComponent = sComponent;
	}

	override public function init():void {
		view.expressionMovieClip.addChild(sComponent);
	}
}
