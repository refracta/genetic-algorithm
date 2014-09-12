/**
 * 개발자 : refracta
 * 날짜   : 2014-08-16 오전 10:48
 */
package com.wg.ga.expression.ui {
import com.refracta.view.MissileUserInterface;
import com.wg.ga.framework.view.PresentationManager;
import com.wg.ga.missile.map.ClickSettingObject;
import com.wg.ga.missile.map.MapLocation;
import com.wg.ga.missile.map.MapObject;
import com.wg.ga.missile.map.MissileMap;
import com.wg.ga.missile.map.MissileObject;
import com.wg.ga.missile.map.MovableObject;

import fl.controls.Slider;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class MissileUserInterfaceWrapper extends MissileUserInterface {
	private var _presentationManager:PresentationManager;
	private var _viewMapData:MissileMap;
	private var _missileMapData:MissileMap;
	private var _entityLocation:MapLocation = null;
	private var _missileLocation:MapLocation = null;
	public function get viewMapData():MissileMap {
		return _viewMapData;
	}


	public function initMap() {
		var cacheVector:Vector.<Vector.<MapObject>> = this.missileMapData.mapData;

		for (var x:int = 0; x < cacheVector.length; x++) {
			for (var y:int = 0; y < cacheVector[x].length; y++) {
				var currentObject:MapObject = cacheVector[x][y];
				if (currentObject as ClickSettingObject) {
					this.missileMapData.setObject(x, y, null);
				}
			}
		}
		this._viewMapData = this.missileMapData.copyMap();

		for (var x:int = 0; x < cacheVector.length; x++) {
			for (var y:int = 0; y < cacheVector[x].length; y++) {
				var currentObject:MapObject = cacheVector[x][y];
				if (currentObject as MovableObject) {
					if (currentObject as MissileObject) {
						//미사일
						this.missileLocation = currentObject.getLocation();
					} else {
						this.entityLocation = currentObject.getLocation();
						//움직
					}
					this.missileMapData.setObject(x, y, null);
				}
			}
		}

	}

	public function get presentationManager():PresentationManager {
		return _presentationManager;
	}

	public function set presentationManager(value:PresentationManager):void {
		_presentationManager = value;
	}

	public function get entityLocation():MapLocation {
		return _entityLocation;
	}

	public function set entityLocation(value:MapLocation):void {
		_entityLocation = value;
	}

	public function get missileLocation():MapLocation {
		return _missileLocation;
	}

	public function set missileLocation(value:MapLocation):void {
		_missileLocation = value;
	}

	public function get missileMapData():MissileMap {
		return _missileMapData;
	}

	public function set missileMapData(value:MissileMap):void {
		_missileMapData = value;
	}

	public function getNumOfGene():uint {

		return this.numOfGene.value;
	}

	public function getSettingObject():String {
		return this.settingObject.value;
	}

	public function MissileUserInterfaceWrapper(presentationManager:PresentationManager) {
		this._presentationManager = presentationManager;
		var updatePresentationViewInfo:Function = function updatePresentationInterface(e:Event) {
			currentView.text = (presentationManager.currentView + 1) + "";
			maxView.text = presentationManager.presentationViews.length + "";
			viewPage.maximum = (presentationManager.presentationViews.length);
			viewPage.value = (presentationManager.currentView + 1);
		};

		var updatePresentationSlider:Function = function updateView(e:Event) {
			presentationManager.moveView(Slider(e.target).value - 1);
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
		this.startButton.dynamicButton.setButtonText(" 시작 ");
		this.playButton.dynamicButton.setButtonText("재생");
		_missileMapData = new MissileMap(getMapWidth(), getMapHeight(), true);
		_missileMapData.objectSize = getCellLength();
	}

	public function getMutationRatio():Number {
		return this.mutationRatio.value;
	}

	public function getSelectionPercent():Number {
		return this.selectionPercent.value;
	}

	public function getNumberOfChangeTry():Number {
		return this.numberOfChangeTry.value;
	}


	public function getOriginalPoolAmount():Number {
		return this.originalPoolAmount.value;
	}

	public function getExitGeneration():uint {
		return this.exitGeneration.value;
	}

	public function getPlayVelocity():uint {
		return this.playVelocity.value;
	}

	public function getCellLength():uint {
		return this.cellLength.value;
	}

	public function getMapHeight():uint {
		return this.mapHeight.value;
	}

	public function getMapWidth():uint {
		return this.mapWidth.value;
	}

}
}
