/**
 * 개발자 : refracta
 * 날짜   : 2014-08-09 오전 9:32
 */
package com.wg.ga.expression.ui {
import com.wg.ga.framework.view.*;

import bkde.as3.boards.GraphingBoardWrapper;

import com.refracta.view.MainUserInterface;
import com.refracta.view.MidnightBlueFlatButton;
import com.wg.ga.framework.view.PresentationManager;


import flash.display.MovieClip;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class MainUserInterfaceWrapper extends MainUserInterface {
	public const absFunction:String = "-abs(x - 20000) + 45000";
	public const quadraticFunction:String = "-0.0001*x*x + 10*x - 200000";
	public const defaultGraphColor:int = 0x2980b9;
	public const defaultGraphThink:int = 2;
	public const binarySize:int = 8 * 2;
	public const defaultSquareSize:Number = 500;
	private var _presentationManager:PresentationManager;

	public function get presentationManager():PresentationManager {
		return _presentationManager;
	}

	public function set presentationManager(value:PresentationManager):void {
		_presentationManager = value;
	}

	public function getMaxY():Number {
		return this.yMaxLimit.value;
	}

	public function getMaxX():Number {
		return this.xMaxLimit.value;
	}
	public function getMutationRatio():Number{
		return this.mutationRatio.value;
	}
	public function getSelectionPercent():Number {
		return this.selectionPercent.value;
	}

	public function getNumberOfChangeTry():Number {
		return this.numberOfChangeTry.value;
	}

	public function getFunctionText():String {
		return this.functionText.text;
	}

	public function getOriginalPoolAmount():Number {
		return this.originalPoolAmount.value;
	}

	public function getExitGeneration():uint {
		return this.exitGeneration.value;
	}

	public function createGraphingBoard():GraphingBoardWrapper {
		var graphingBoardWrapper:GraphingBoardWrapper = new GraphingBoardWrapper(this.defaultSquareSize);
		graphingBoardWrapper.setVarsRanges(0, this.getMaxX(), 0, this.getMaxY());
		graphingBoardWrapper.drawAxes();
		graphingBoardWrapper.setMaxNumGraphs(getOriginalPoolAmount()+1);
		return graphingBoardWrapper;

	}

	public function drawSettingGraph(graphingBoard:GraphingBoardWrapper):void {
		graphingBoard.setVarsRanges(0, this.getMaxX(), 0, this.getMaxY());
		graphingBoard.drawAxes();
		graphingBoard.drawFunction(this.functionText.text, 1, this.defaultGraphThink, this.defaultGraphColor);
	}

	public function MainUserInterfaceWrapper(presentationManager:PresentationManager) {

		this._presentationManager = presentationManager;
		var updatePresentationViewInfo:Function = function updatePresentationInterface(e:Event) {
			currentView.text = (presentationManager.currentView + 1) + "";
			maxView.text = presentationManager.presentationViews.length + "";
			viewPage.maximum = (presentationManager.presentationViews.length);
			viewPage.value = (presentationManager.currentView + 1);
		};

		var updatePresentationSlider:Function = function updateView(e:Event) {
			presentationManager.moveView(e.target.value - 1);

		};
		var keyBoardEvent:Function = function updateNextPresentation(e:KeyboardEvent) {
			if (e.keyCode == Keyboard.RIGHT) {
				trace("NEXT PRESENTATION : " + presentationManager.nextPresentation())
			} else if (e.keyCode == Keyboard.LEFT) {
				trace("PREV PRESENTATION : " + presentationManager.prevPresentation());
			}
		};

		var stageEventFunctionInit:Function = function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, stageEventFunctionInit);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardEvent);
		};
		this.addEventListener(Event.ADDED_TO_STAGE, stageEventFunctionInit);
		this.viewPage.addEventListener(Event.CHANGE, updatePresentationSlider);
		this.addEventListener(Event.ENTER_FRAME, updatePresentationViewInfo);
		this.startButton.dynamicButton.setButtonText("시작");
	}
}
}
