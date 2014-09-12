/**
 * 개발자 : refracta
 * 날짜   : 2014-08-24 오전 2:54
 */
package com.wg.ga.expression.scene.physical {


import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;

import com.wg.ga.expression.ui.SimulationUserInterfaceWrapper;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;
import com.wg.ga.physical.element.ArriveContactListener;
import com.wg.ga.physical.entity.BallEntity;
import com.wg.ga.starter.phycical.PhysicalSimulation;

import flash.events.Event;

import flash.events.TimerEvent;

import flash.utils.Timer;

public class BallSimulationScene extends Scene {
	private var userInterface:SimulationUserInterfaceWrapper;

	public function BallSimulationScene(userInterface:SimulationUserInterfaceWrapper) {
		this.userInterface = userInterface;

	}


	override public function init():void {
		this.view.viewIn = function () {
			var currentIndex:int = userInterface.presentationManager.presentationViews.indexOf(view) - 1;
			userInterface.clearLog();
			userInterface.appendLogText("Generation : " + currentIndex);
		}
	}

	public function playSimulation(physicalSimulation:PhysicalSimulation) {
		var currentIndex:int = userInterface.presentationManager.presentationViews.indexOf(this.view) - 1;

		var updateEntities:Vector.<BallEntity> = userInterface.simulationData[currentIndex];
		userInterface.simulationWorld.world.SetContactListener(new ArriveContactListener());
		userInterface.simulationWorld.arrivalPoint.SetUserData("ARRIVE");
		for (var i:int = 0; i < updateEntities.length; i++) {
			var currentBall:b2Body = userInterface.simulationWorld.addBall();
			currentBall.SetUserData("WAIT");
			currentBall.ApplyForce(userInterface.startForceValue, currentBall.GetWorldCenter());
		}
		var geneLength:uint = updateEntities[0].getGeneInformation().length;
		var time:uint = 0;
		var currentGene = 0;

		function playData() {
			userInterface.clearLog();
			userInterface.appendLogText("Generation : " + currentIndex);
			userInterface.appendLogText("Best Entity : " + userInterface.bestEntities[currentIndex].toString());
			userInterface.appendLogText("Gene Progress : " + currentGene + " / " + geneLength);
			if (currentGene == geneLength) {
				userInterface.simulationWorld.clearBalls();
				physicalSimulation.playing = false;
				return;
			}
			var currentGeneForceApply:uint = 0;
			var geneForceApplyTimer:Timer = new Timer(userInterface.stepTimeValue * 1000, userInterface.geneForceApplyingTimeValue);

			function geneForceApplyFunction(e:Event) {
				for (var faf:int = 0; faf < updateEntities.length; faf++) {
					var currentBallBody:b2Body = userInterface.simulationWorld.ballList[faf];
					if (currentBallBody != null) {
						var currentEntity:BallEntity = updateEntities[faf];
//						trace("GENEFORMATION"+currentEntity.getGeneInformation())
						var currentDirectionGene:DirectionGene = DirectionGene(currentEntity.getGeneInformation()[currentGene]);
						var geneForce:b2Vec2 = getGeneForce(userInterface.geneForceValue, currentDirectionGene);
//						trace("GENE FORCE : "+geneForce.x+"/"+geneForce.y)
						currentBallBody.ApplyForce(geneForce, currentBallBody.GetWorldCenter());
						if (userInterface.enableResistanceValue) {
							currentBallBody.ApplyForce(userInterface.simulationWorld.getAirResistanceVector(currentBallBody.GetLinearVelocity()), currentBallBody.GetWorldCenter());
						}
					}
				}
				time++;
				userInterface.simulationWorld.update();
				for (var faf2:int = 0; faf2 < updateEntities.length; faf2++) {

					var currentBallBody:b2Body = userInterface.simulationWorld.ballList[faf2];
					var currentEntity:BallEntity = updateEntities[faf2];

					if (currentBallBody != null) {
						if (currentBallBody.GetUserData() == "CONTACTED") {
							currentEntity.totalGeneFitness = time;
							userInterface.simulationWorld.world.DestroyBody(currentBallBody);
							userInterface.simulationWorld.ballList[faf2] = null;
						}
					}
				}
				currentGeneForceApply++;
			}

			function geneForceApplyComplete(e:Event) {
				//인터벌 시작
				var currentGeneForceInterval:uint = 0;
				var geneForceIntervalTimer:Timer = new Timer(userInterface.stepTimeValue * 1000, userInterface.geneForceIntervalTimeValue);

				function geneForceIntervalFunction(e:Event) {
					time++;
					userInterface.simulationWorld.update();
					for (var fif:int = 0; fif < updateEntities.length; fif++) {
						var currentBallBody:b2Body = userInterface.simulationWorld.ballList[fif];
						var currentEntity:BallEntity = updateEntities[fif];
						if (currentBallBody != null) {
							if (currentBallBody.GetUserData() == "CONTACTED") {
								currentEntity.totalGeneFitness = time;
								userInterface.simulationWorld.world.DestroyBody(currentBallBody);
								userInterface.simulationWorld.ballList[fif] = null;
							}
						}
					}
					currentGeneForceInterval++;
				}

				function geneForceIntervalComplete(e:Event) {
					currentGene++;
					playData();
				}

				geneForceIntervalTimer.start();

				geneForceIntervalTimer.addEventListener(TimerEvent.TIMER, geneForceIntervalFunction);
				geneForceIntervalTimer.addEventListener(TimerEvent.TIMER_COMPLETE, geneForceIntervalComplete);
			}

			geneForceApplyTimer.addEventListener(TimerEvent.TIMER, geneForceApplyFunction);
			geneForceApplyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, geneForceApplyComplete);
			geneForceApplyTimer.start();
		}

		playData();


	}

	public function getGeneForce(forceValue:Number, gene:DirectionGene):b2Vec2 {
		forceValue = Math.abs(forceValue);
		var force:b2Vec2 = new b2Vec2();
		switch (gene.direction) {
			case "EAST":
				force.Set(forceValue, 0);
				break;
			case "WEST":
				force.Set(-forceValue, 0);
				break;
			case "SOUTH":
				force.Set(0, forceValue);
				break;
			case "NORTH":
				force.Set(0, -forceValue);
				break;


		}
		return force

	}

}
}
