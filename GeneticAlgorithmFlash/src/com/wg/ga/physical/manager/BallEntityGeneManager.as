/**
 * 개발자 : refracta
 * 날짜   : 2014-08-23 오후 1:26
 */
package com.wg.ga.physical.manager {
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;

import com.wg.ga.expression.ui.SimulationUserInterfaceWrapper;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.framework.manager.GeneManager;
import com.wg.ga.framework.util.Random;
import com.wg.ga.physical.element.ArriveContactListener;
import com.wg.ga.physical.entity.BallEntity;
import com.wg.ga.physical.logic.impl.BallRandomPointCrossoverLogic;
import com.wg.ga.physical.world.SimulationWorld;

import flash.events.Event;

import flash.system.System;

public class BallEntityGeneManager implements GeneManager {

	private var originalPoolAmount:int;
	private var mutationRatio:int;

	public function BallEntityGeneManager(originalPoolAmount:int, mutationRatio:int) {
		this.originalPoolAmount = originalPoolAmount;
		this.mutationRatio = mutationRatio;
	}

	public function makeRandomUnlimitedGeneList():Vector.<Gene> {
		return null;
	}

	public function getRandomIndexCrossoverEntities(crossoverLogic:CrossoverLogic, entities:Vector.<BallEntity>):Vector.<BallEntity> {
		var childEntities:Vector.<BallEntity> = new Vector.<BallEntity>();
		var size:int = entities.length;
		if (size < 2) {
			try {
				throw new Error("MissileTargetEntity list size is small");
			} catch (e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}
		for (var i:int = 0; i < originalPoolAmount; i++) {
			var randomIndex1:int = Random.nextInt(size);
			var randomIndex2:int = Random.nextInt(size);
			for (; randomIndex1 == randomIndex2; randomIndex1 = Random.nextInt(size)) ;
			var source1:BallEntity = entities[randomIndex1];
			var source2:BallEntity = entities[randomIndex2];
			var reproductionEntity:BallEntity = BallEntity(crossoverLogic.createCrossoverEntity(source1, source2));
			childEntities.push(reproductionEntity);
		}
		return childEntities;
	}

	public function setMutateEntity(mutateLogic:MutationLogic, targetEntities:Vector.<BallEntity>):void {
		for (var i:int = 0; i < targetEntities.length; i++) {
			if (Random.nextProbability(mutationRatio)) {
				var mutation:Entity = mutateLogic.createMutation(targetEntities[i]);
				targetEntities[i] = BallEntity(mutation);
			}
		}
	}


	public function makeRandomLimitGeneList(numOfGene:int):Vector.<Gene> {
		var geneInformation:Vector.<DirectionGene> = new Vector.<DirectionGene>();
		for (var i:int = 0; i < numOfGene; i++) {
			geneInformation.push(DirectionGene.GENE_LIST[Random.nextInt(DirectionGene.GENE_LIST.length)]);
		}
		return Vector.<Gene>(geneInformation);
	}

	public function getFirstLimitEntities(geneLengthValue:Number, numberOfEntityValue:Number):Vector.<BallEntity> {
		var entityList:Vector.<BallEntity> = new Vector.<BallEntity>();
		for (var i:int = 0; i < numberOfEntityValue; i++) {
			entityList.push(getLimitMissileTargetEntity(geneLengthValue));
		}
		return entityList;


	}

	public function getLimitMissileTargetEntity(numOfGene:int):BallEntity {
		var genes:Vector.<DirectionGene> = Vector.<DirectionGene>(makeRandomLimitGeneList(numOfGene));
		var returnEntity:BallEntity = new BallEntity(genes);
		return returnEntity;
	}

	public function fitnessUpdateOldOld(userInterface:SimulationUserInterfaceWrapper, updateEntities:Vector.<BallEntity>) {
		for (var i:int = 0; i < updateEntities.length; i++) {
			var currentBall:b2Body = userInterface.simulationWorld.addBall();
//			currentBall.GetFixtureList().SetSensor(true);
//			currentBall.SetUserData("WAIT");
//			currentBall.ApplyForce(userInterface.startForceValue, currentBall.GetWorldCenter());
		}
		userInterface.addEventListener(Event.ENTER_FRAME, enter);
		function enter(e:Event) {
			userInterface.simulationWorld.update();
		}
	}

	public function fitnessUpdate(userInterface:SimulationUserInterfaceWrapper, updateEntities:Vector.<BallEntity>) {
		var geneLength:uint = updateEntities[0].getGeneInformation().length;
		var maxTime:uint = geneLength * userInterface.geneForceIntervalTimeValue + geneLength * userInterface.geneForceApplyingTimeValue;
		userInterface.simulationWorld.world.SetContactListener(new ArriveContactListener());
		userInterface.simulationWorld.arrivalPoint.SetUserData("ARRIVE");
		for (var i:int = 0; i < updateEntities.length; i++) {
			var currentBall:b2Body = userInterface.simulationWorld.addBall();
			currentBall.SetUserData("WAIT");
			currentBall.ApplyForce(userInterface.startForceValue, currentBall.GetWorldCenter());
		}

		var time:uint = 0;
		for (var currentGene:uint = 0; currentGene < geneLength; currentGene++) {
			for (var t:int = 0; t < userInterface.geneForceApplyingTimeValue; t++) {
				for (var i:int = 0; i < updateEntities.length; i++) {
					var currentBallBody:b2Body = userInterface.simulationWorld.ballList[i];
					if (currentBallBody != null) {
						var currentEntity:BallEntity = updateEntities[i];
						var currentDirectionGene:DirectionGene = DirectionGene(currentEntity.getGeneInformation()[currentGene]);

						currentBallBody.ApplyForce(getGeneForce(userInterface.geneForceValue, currentDirectionGene), currentBallBody.GetWorldCenter());
						if (userInterface.enableResistanceValue) {
							currentBallBody.ApplyForce(userInterface.simulationWorld.getAirResistanceVector(currentBallBody.GetLinearVelocity()), currentBallBody.GetWorldCenter());
						}
					}
				}
				time++;
				userInterface.simulationWorld.nonDrawUpdate();
				//평가
				for (var i:int = 0; i < updateEntities.length; i++) {

					var currentBallBody:b2Body = userInterface.simulationWorld.ballList[i];
					var currentEntity:BallEntity = updateEntities[i];

					if (currentBallBody != null) {
						if (currentBallBody.GetUserData() == "CONTACTED") {
							currentEntity.totalGeneFitness = maxTime - time;
							userInterface.simulationWorld.world.DestroyBody(currentBallBody);
							userInterface.simulationWorld.ballList[i] = null;
						}


					}
				}


			}

			for (var t:int = 0; t < userInterface.geneForceIntervalTimeValue; t++) {
				time++;
				userInterface.simulationWorld.nonDrawUpdate();
				//평가
				for (var i:int = 0; i < updateEntities.length; i++) {
					var currentBallBody:b2Body = userInterface.simulationWorld.ballList[i];
					var currentEntity:BallEntity = updateEntities[i];
					if (currentBallBody != null) {
						if (currentBallBody.GetUserData() == "CONTACTED") {
							currentEntity.totalGeneFitness = maxTime - time;
							userInterface.simulationWorld.world.DestroyBody(currentBallBody);
							userInterface.simulationWorld.ballList[i] = null;
						}
					}
				}


			}

		}
		for (var i:int = 0; i < updateEntities.length; i++) {
			var currentEntity:BallEntity = updateEntities[i];
			var currentBallBody:b2Body = userInterface.simulationWorld.ballList[i];

			if (isNaN(currentEntity.getBallGeneFitness())) {

				var v1:b2Vec2 = currentBallBody.GetPosition();
				var v2:b2Vec2 = userInterface.simulationWorld.arrivalPoint.GetWorldCenter();
				var fitness:Number = -1 * getVectorLocation(v1, v2);
				currentEntity.totalGeneFitness = fitness;
			}
		}
		userInterface.simulationWorld.clearBalls();
	}

	public function getVectorLocation(v1:b2Vec2, v2:b2Vec2) {
		var xCalculate:Number = Math.pow(v1.x - v2.x, 2);
		var yCalculate:Number = Math.pow(v1.y - v2.y, 2);
		var total:Number = Math.pow(xCalculate + yCalculate, 0.5);
		return total;
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
