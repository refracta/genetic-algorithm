/**
 * 개발자 : refracta
 * 날짜   : 2014-08-22 오전 1:06
 */
package com.wg.ga.starter.phycical {
import Box2D.Dynamics.b2Body;

import com.refracta.view.DynamicButton;
import com.wg.ga.expression.scene.physical.BallSimulationScene;

import com.wg.ga.expression.ui.SimulationUserInterfaceWrapper;

import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

[SWF(backgroundColor="0xffffff", width="750", height="675", frameRate='60')]
public class PhysicalSimulation extends MovieClip {
	private var _userInterface:SimulationUserInterfaceWrapper;

	public function startLogic(e:DynamicButton) {
		if (_userInterface.initField()) {
			if(start == false){
			_userInterface.startSetting();
			this._start = true;
			}
		} else {
			_userInterface.clearLog();
			_userInterface.appendLogText("Field Parameter Value Error");
		}
	}

	private var _playing:Boolean = false;
	private var _start:Boolean = false;

	public function get userInterface():SimulationUserInterfaceWrapper {
		return _userInterface;
	}

	public function set userInterface(value:SimulationUserInterfaceWrapper):void {
		_userInterface = value;
	}

	public function get playing():Boolean {
		return _playing;
	}

	public function set playing(value:Boolean):void {
		_playing = value;
	}

	public function get start():Boolean {
		return _start;
	}

	public function set start(value:Boolean):void {
		_start = value;
	}

	public function playLogic(e:DynamicButton) {

		if (playing == false && start) {
			if (_userInterface.presentationManager.getCurrentView().scene as BallSimulationScene) {
				BallSimulationScene(_userInterface.presentationManager.getCurrentView().scene).playSimulation(this);
				_playing = true;
			}
		}
	}

	public function PhysicalSimulation() {
		var backgroundMC:MovieClip = new MovieClip();
		backgroundMC.graphics.beginFill(0xffff00,1);
		backgroundMC.graphics.drawRect(100,100,100,100);

		this._userInterface = new SimulationUserInterfaceWrapper();
		DynamicButton(this._userInterface.startButton.dynamicButton).addEventButtonListener(startLogic);
		DynamicButton(this._userInterface.playButton.dynamicButton).addEventButtonListener(playLogic);
		this.addChild(_userInterface);
		this.addEventListener(Event.ADDED_TO_STAGE, stageAddFunction);
		this.addChild(this._userInterface.presentationManager.presentationViewClip);
	}

	function stageAddFunction(e:Event) {
		this.removeEventListener(Event.ADDED_TO_STAGE, stageAddFunction);
		this.userInterface.clickedArea.addEventListener(MouseEvent.CLICK, clickAction);

	}

	public function clickAction(e:MouseEvent) {
		if (!_playing && !_start) {
			var currentX:Number = MovieClip(e.currentTarget).mouseX;
			var currentY:Number = MovieClip(e.currentTarget).mouseY;
			var viewCache:MovieClip = this._userInterface.simulationWorld.view;
			var xCheck:Boolean = viewCache.x <= currentX && currentX <= viewCache.x + viewCache.width;
			var yCheck:Boolean = viewCache.y <= currentY && currentY <= viewCache.y + viewCache.height;


			if (xCheck && yCheck) {
				var check:Boolean = this._userInterface.initField();
				if (!check) {
					this._userInterface.appendLogText("Field Parameter Error");
					return;
				}
				var innerX:Number = currentX - viewCache.x;
				var innerY:Number = currentY - viewCache.y;

				switch (this._userInterface.clickComboBox.value) {
					case "BLOCKAGE":
						var blockageSideLength:Number = Number(this._userInterface.blockageSideLength.text) / 2 * this._userInterface.simulationWorld.drawPixelToMeterScale;
						this._userInterface.simulationWorld.blockageSize = blockageSideLength;
						this._userInterface.simulationWorld.addBlockage(innerX, innerY);
						break;
					case "BALL":
						var pointBallSize:Number = Number(this._userInterface.ballRadius.text) * this._userInterface.simulationWorld.drawPixelToMeterScale;
						this._userInterface.simulationWorld.setPointBall(pointBallSize, innerX, innerY);

						break;
					case "CLEAR_BLOCKAGE":
						this._userInterface.simulationWorld.clearBlockages();
						break;
					case "ARRIVAL_POINT":
						this._userInterface.simulationWorld.setArrivalPoint(innerX, innerY)
						break;
				}
				this._userInterface.simulationWorld.update();
			}


			/*		var mouseXPos:Number = MovieClip(e.currentTarget).mouseX;
			 var mouseYPos:Number = MovieClip(e.currentTarget).mouseY;*/
			/*	*/
		}
	}
}
}
