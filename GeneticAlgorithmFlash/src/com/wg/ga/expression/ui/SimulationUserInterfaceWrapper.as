/**
 * 개발자 : refracta
 * 날짜   : 2014-08-21 오후 11:49
 */
package com.wg.ga.expression.ui {
import Box2D.Dynamics.b2Body;

import com.refracta.view.SimulationUserInterface;
import com.wg.ga.expression.scene.physical.BallSimulationScene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.impl.HighScoreSelectionLogic;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.framework.view.PresentationManager;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;
import com.wg.ga.physical.entity.BallEntity;
import com.wg.ga.physical.logic.impl.BallHighScoreRouletteWheelSelectionLogic;
import com.wg.ga.physical.logic.impl.BallMutationLogic;
import com.wg.ga.physical.logic.impl.BallRandomPointCrossoverLogic;
import com.wg.ga.physical.manager.BallEntityGeneManager;
import com.wg.ga.physical.world.ExtendsWorld;
import com.wg.ga.physical.world.SimulationWorld;

import Box2D.Common.Math.b2Vec2;

import com.wg.ga.starter.phycical.PhysicalSimulation;

import fl.controls.Slider;

import fl.controls.TextInput;

import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.TextEvent;

import flash.sensors.Accelerometer;

import flash.system.System;
import flash.text.TextField;
import flash.ui.Keyboard;

/*
 캐싱해야할 것들
 enableAir
 DensityOfTheF
 DragCoeffi
 Area

 ballfrict
 startForce
 elasticity
 density
 radius
 mass
 coefficient of friction
 side length
 step time
 vGra
 hGra
 selectionRa
 MutationRa
 MutationS
 EndGener
 NumofEntity
 */


public class SimulationUserInterfaceWrapper extends SimulationUserInterface {
	private var _presentationManager:PresentationManager;

	{

		public function get areaValue():Number {
			return _areaValue;
		}

		public function set areaValue(value:Number):void {
			_areaValue = value;
		}

		public function get enableResistanceValue():Boolean {
			return _enableResistanceValue;
		}

		public function set enableResistanceValue(value:Boolean):void {
			_enableResistanceValue = value;
		}

		public function get densityOfFluidValue():Number {
			return _densityOfFluidValue;
		}

		public function set densityOfFluidValue(value:Number):void {
			_densityOfFluidValue = value;
		}

		public function get dragCoefficientValue():Number {
			return _dragCoefficientValue;
		}

		public function set dragCoefficientValue(value:Number):void {
			_dragCoefficientValue = value;
		}

		public function get ballFrictionValue():Number {
			return _ballFrictionValue;
		}

		public function set ballFrictionValue(value:Number):void {
			_ballFrictionValue = value;
		}

		public function get startForceValue():b2Vec2 {
			return _startForceValue;
		}

		public function set startForceValue(value:b2Vec2):void {
			_startForceValue = value;
		}

		public function get ballElasticityValue():Number {
			return _ballElasticityValue;
		}

		public function set ballElasticityValue(value:Number):void {
			_ballElasticityValue = value;
		}

		public function get ballDensityValue():Number {
			return _ballDensityValue;
		}

		public function set ballDensityValue(value:Number):void {
			_ballDensityValue = value;
		}

		public function get ballRadiusValue():Number {
			return _ballRadiusValue;
		}

		public function set ballRadiusValue(value:Number):void {
			_ballRadiusValue = value;
		}

		public function get blockageFrictionValue():Number {
			return _blockageFrictionValue;
		}

		public function set blockageFrictionValue(value:Number):void {
			_blockageFrictionValue = value;
		}

		public function get blockageSideLengthValue():Number {
			return _blockageSideLengthValue;
		}

		public function set blockageSideLengthValue(value:Number):void {
			_blockageSideLengthValue = value;
		}

		public function get stepTimeValue():Number {
			return _stepTimeValue;
		}

		public function set stepTimeValue(value:Number):void {
			_stepTimeValue = value;
		}

		public function get verticalGravityValue():Number {
			return _verticalGravityValue;
		}

		public function set verticalGravityValue(value:Number):void {
			_verticalGravityValue = value;
		}

		public function get horizontalGravityValue():Number {
			return _horizontalGravityValue;
		}

		public function set horizontalGravityValue(value:Number):void {
			_horizontalGravityValue = value;
		}

		public function get selectionRatioValue():Number {
			return _selectionRatioValue;
		}

		public function set selectionRatioValue(value:Number):void {
			_selectionRatioValue = value;
		}

		public function get mutationRatioValue():Number {
			return _mutationRatioValue;
		}

		public function set mutationRatioValue(value:Number):void {
			_mutationRatioValue = value;
		}

		public function get mutationStrengthValue():Number {
			return _mutationStrengthValue;
		}

		public function set mutationStrengthValue(value:Number):void {
			_mutationStrengthValue = value;
		}

		public function get endGenerationValue():Number {
			return _endGenerationValue;
		}

		public function set endGenerationValue(value:Number):void {
			_endGenerationValue = value;
		}

		public function get numberOfEntityValue():Number {
			return _numberOfEntityValue;
		}

		public function set numberOfEntityValue(value:Number):void {
			_numberOfEntityValue = value;
		}

		public function get geneForceValue():Number {
			return _geneForceValue;
		}

		public function set geneForceValue(value:Number):void {
			_geneForceValue = value;
		}

		public function get geneLengthValue():Number {
			return _geneLengthValue;
		}

		public function set geneLengthValue(value:Number):void {
			_geneLengthValue = value;
		}

		public function get geneForceApplyingTimeValue():Number {
			return _geneForceApplyingTimeValue;
		}

		public function set geneForceApplyingTimeValue(value:Number):void {
			_geneForceApplyingTimeValue = value;
		}

		public function get geneForceIntervalTimeValue():Number {
			return _geneForceIntervalTimeValue;
		}

		public function set geneForceIntervalTimeValue(value:Number):void {
			_geneForceIntervalTimeValue = value;
		}
	}
	private var _simulationData:Vector.<Vector.<BallEntity>> = new Vector.<Vector.<BallEntity>>();
	private var _bestEntities:Vector.<BallEntity> = new Vector.<BallEntity>();
	private var _simulationWorld:SimulationWorld;
	private var _areaValue:Number;

	public function get simulationWorld():SimulationWorld {
		return _simulationWorld;
	}

	/*물리 세계 설정*/
	private var _enableResistanceValue:Boolean;
	private var _densityOfFluidValue:Number;
	private var _dragCoefficientValue:Number;

	private var _ballFrictionValue:Number;
	private var _startForceValue:b2Vec2;
	private var _ballElasticityValue:Number;
	private var _ballDensityValue:Number;
	private var _ballRadiusValue:Number;
	private var _blockageFrictionValue:Number;
	private var _blockageSideLengthValue:Number;
	private var _stepTimeValue:Number;
	private var _verticalGravityValue:Number;
	private var _horizontalGravityValue:Number;
	private var _selectionRatioValue:Number;
	private var _mutationRatioValue:Number;
	private var _mutationStrengthValue:Number;
	private var _endGenerationValue:Number;
	private var _numberOfEntityValue:Number;

	private var _geneForceValue:Number;
	private var _geneLengthValue:Number;
	private var _geneForceApplyingTimeValue:Number;
	private var _geneForceIntervalTimeValue:Number;

	public function parseNumber(string:String) {
		var parsing:Number = parseFloat(string);


		if (isNaN(parsing)) {

			throw Error("Cast Error");
		} else {
			return parsing;
		}
	}

	public function initField():Boolean {
		try {
			this._enableResistanceValue = this.enableResistance.selected;
			this._densityOfFluidValue = parseNumber(this.densityOfFluid.text);
			this._dragCoefficientValue = parseNumber(this.dragCoefficient.text);

			this._ballFrictionValue = parseNumber(this.ballFriction.text);
			var startForceSplit:Array = this.startForce.text.split("/");
			this._startForceValue = new b2Vec2(parseNumber(startForceSplit[0]), parseNumber(startForceSplit[1]));
			this._ballElasticityValue = parseNumber(this.ballElasticity.text);
			this._ballDensityValue = parseNumber(this.ballDensity.text);
			this._ballRadiusValue = parseNumber(this.ballRadius.text);
			//매스는 나중에 초기화;
			this._blockageFrictionValue = parseNumber(this.blockageFriction.text);
			this._blockageSideLengthValue = parseNumber(this.blockageSideLength.text);
			this._stepTimeValue = 1 / parseNumber(this.stepTime.text);
			this._verticalGravityValue = parseNumber(this.verticalGravity.text);
			this._horizontalGravityValue = parseNumber(this.horizontalGravity.text);

			this._selectionRatioValue = parseNumber(this.selectionRatio.text);
			this._mutationRatioValue = parseNumber(this.mutationRatio.text);
			this._mutationStrengthValue = parseNumber(this.mutationStrength.text);
			this._endGenerationValue = parseNumber(this.endGeneration.text);
			this._numberOfEntityValue = parseNumber(this.numberOfEntity.text);

			this._geneForceValue = parseNumber(this.geneForce.text);
			this._geneLengthValue = parseNumber(this.geneLength.text);
			this._geneForceApplyingTimeValue = parseNumber(this.geneForceApplyingTime.text);
			this._geneForceIntervalTimeValue = parseNumber(this.geneForceIntervalTime.text);
			this._areaValue = this._ballRadiusValue * this._ballRadiusValue * Math.PI
			this.area.text = this._areaValue + "";
		} catch (e:Error) {
			return false;
		}
		return true;
	}

	public function lockUI() {
		this.enableResistance.enabled = false;
		this.densityOfFluid.enabled = false;
		this.dragCoefficient.enabled = false;
		this.area.enabled = false;
		this.ballFriction.enabled = false;
		var startForceSplit:Array = this.startForce.text.split("/");
		this.startForce.enabled = false;
		this.ballElasticity.enabled = false;
		this.ballDensity.enabled = false;
		this.ballRadius.enabled = false;
		//매스는 나중에 초기화;
		this.blockageFriction.enabled = false;
		this.blockageSideLength.enabled = false;
		this.stepTime.enabled = false;
		this.verticalGravity.enabled = false;
		this.horizontalGravity.enabled = false;

		this.selectionRatio.enabled = false;
		this.mutationRatio.enabled = false;
		this.mutationStrength.enabled = false;
		this.endGeneration.enabled = false;
		this.numberOfEntity.enabled = false;

		this.geneForce.enabled = false;
		this.geneLength.enabled = false;
		this.geneForceApplyingTime.enabled = false;
		this.geneForceIntervalTime.enabled = false;
	}

	public function appendLogText(message:String) {
		this.log.text = this.log.text + "\n" + message;
		trace(message);
	}

	public function clearLog() {
		this.log.text = "Log Text Field";
		trace("Clear Log");
	}

	public function removeLine():Boolean {
		try {
			var log:String = this.log.text;
			var lineRemoveLog:String = log.substring(0, log.lastIndexOf("\r"));
			this.log.text = lineRemoveLog;
		} catch (e:Error) {
			return false;
		}
		return true;
	}

	public function changeBallRadius(e:Event) {
		if (initField()) {
			var location:b2Vec2 = this.simulationWorld.pointBall.GetPosition();
			this.simulationWorld.setPointBall(this._ballRadiusValue * simulationWorld.drawPixelToMeterScale, location.x * simulationWorld.drawPixelToMeterScale, location.y * simulationWorld.drawPixelToMeterScale)
			this.simulationWorld.update();
		} else {
			clearLog();
			appendLogText("Field Parameter Value Error");
		}
	}

	public function startSetting() {

			clearLog();
			appendLogText("Ready Check Success");
			lockUI();
			appendLogText("Locking User Interface");
			appendLogText("Initializes Physical World");
			physicalWorldSetting();
			updateTextData();
			startSimulation();

	}

	private function updateTextData():void {
		this.ballMass.text = this.simulationWorld.addBall().GetMass() + "";
		this.simulationWorld.clearBalls();
	}

	private function physicalWorldSetting():void {
		simulationWorld.ballFriction = this._ballFrictionValue;
		simulationWorld.ballDensity = this._ballDensityValue;
		simulationWorld.ballElasticity = this._ballElasticityValue;
		simulationWorld.ballLocationCache = simulationWorld.pointBall.GetPosition();
		simulationWorld.componentFriction = this._blockageFrictionValue;
		simulationWorld.stepTime = this._stepTimeValue;
		simulationWorld.ballRadius = this._ballRadiusValue;
		simulationWorld.dragC = this._dragCoefficientValue;
		simulationWorld.objectArea = this._areaValue;
		simulationWorld.pressure = this._densityOfFluidValue;

		simulationWorld.verticalGravity = this._verticalGravityValue;
		simulationWorld.horizontalGravity = this._horizontalGravityValue;

//		simulationWorld.world.SetGravity(new b2Vec2(_verticalGravityValue, _horizontalGravityValue));


		simulationWorld.arrivalPoint.GetFixtureList().SetFriction(simulationWorld.componentFriction);
		//도착지 프릭션 초기화
		for (var i:int = 0; i < simulationWorld.blockageBodes.length; i++) {
			var body:b2Body = simulationWorld.blockageBodes[i];
			body.GetFixtureList().SetFriction(simulationWorld.componentFriction);
		}
		//장애물 프릭션 초기화
		simulationWorld.topBedRockBody.GetFixtureList().SetFriction(simulationWorld.componentFriction);
		simulationWorld.bottomBedRockBody.GetFixtureList().SetFriction(simulationWorld.componentFriction);
		simulationWorld.rightBedRockBody.GetFixtureList().SetFriction(simulationWorld.componentFriction);
		simulationWorld.leftBedRockBody.GetFixtureList().SetFriction(simulationWorld.componentFriction);
		//배드락 프릭션 초기화

		simulationWorld.world.DestroyBody(simulationWorld.pointBall);
		//공 없애기



		simulationWorld.update();

	}

	public static function getBestEntity(entities:Vector.<BallEntity>):Entity {
		entities.sort(new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER).compare);
		return entities[0];
	}

	private function startSimulation():void {
		var geneManager:BallEntityGeneManager = new BallEntityGeneManager(this._numberOfEntityValue, this._mutationRatioValue);
		var crossoverLogic:BallRandomPointCrossoverLogic = new BallRandomPointCrossoverLogic();
		var selectionLogic1:SelectionLogic = new HighScoreSelectionLogic(this._selectionRatioValue/2);
		var selectionLogic2:SelectionLogic = new BallHighScoreRouletteWheelSelectionLogic(this._selectionRatioValue/2,true);
		var mutationLogic:MutationLogic = new BallMutationLogic(this._mutationStrengthValue);
		var entityGroup:Vector.<BallEntity> = geneManager.getFirstLimitEntities(this._geneLengthValue, this._numberOfEntityValue);
//		var es:BasicEntityComparator = new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER);
		//적합도 평가
		geneManager.fitnessUpdate(this, entityGroup);
		bestEntities.push(getBestEntity(entityGroup));
		trace("CURRENT ENTITY ["+0+"]: "+entityGroup);
		this._presentationManager.presentationViews.push(new View(new BallSimulationScene(this)));
		_simulationData.push(entityGroup);
		for (var i:int = 0; i < this._endGenerationValue; i++) {
//			적합도 평가
			var selectGene1:Vector.<BallEntity> = Vector.<BallEntity>(selectionLogic1.getSelectGene(Vector.<Entity>(entityGroup))); //적합도 사용
			var selectGene2:Vector.<BallEntity> = Vector.<BallEntity>(selectionLogic2.getSelectGene(Vector.<Entity>(entityGroup))); //적합도 사용
			selectGene1 = selectGene1.concat(selectGene2);
			var crossoverEntities:Vector.<BallEntity> = geneManager.getRandomIndexCrossoverEntities(crossoverLogic, selectGene1);
			geneManager.setMutateEntity(mutationLogic, crossoverEntities);
			entityGroup = crossoverEntities;
			geneManager.fitnessUpdate(this, entityGroup);
			bestEntities.push(getBestEntity(entityGroup));
			trace("CURRENT ENTITY ["+(i+1)+"]: "+entityGroup);
			this._presentationManager.presentationViews.push(new View(new BallSimulationScene(this)));
			_simulationData.push(entityGroup);
		}
		trace("BE : " + bestEntities);
	}

	public function SimulationUserInterfaceWrapper() {
		this.playButton.dynamicButton.setButtonText("재생");
		this.startButton.dynamicButton.setButtonText("시작");
		this._simulationWorld = new SimulationWorld(430, 430);
		var pointBallSize:Number = Number(this.ballRadius.text) * this._simulationWorld.drawPixelToMeterScale;
		this._simulationWorld.setPointBall(pointBallSize, pointBallSize * 2, pointBallSize * 2);
		this._simulationWorld.setArrivalPoint(400, 420);
		this._simulationWorld.view.x = 305;
		this._simulationWorld.view.y = 42;
		this.addChild(this._simulationWorld.view);
		TextInput(this.ballRadius).addEventListener(Event.CHANGE, changeBallRadius);
		this._simulationWorld.update();
		this._presentationManager = new PresentationManager();

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

		this._presentationManager.presentationViews.push(new View(new Scene()));
		this.presentationManager.start();


	}

	public function get presentationManager():PresentationManager {
		return _presentationManager;
	}

	public function set presentationManager(value:PresentationManager):void {
		_presentationManager = value;
	}

	public function get simulationData():Vector.<Vector.<BallEntity>> {
		return _simulationData;
	}

	public function set simulationData(value:Vector.<Vector.<BallEntity>>):void {
		_simulationData = value;
	}

	public function get bestEntities():Vector.<BallEntity> {
		return _bestEntities;
	}

	public function set bestEntities(value:Vector.<BallEntity>):void {
		_bestEntities = value;
	}
}
}
