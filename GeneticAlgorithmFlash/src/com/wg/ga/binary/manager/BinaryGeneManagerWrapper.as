/**
 * 개발자 : refracta
 * 날짜   : 2014-08-13 오전 2:47
 */
package com.wg.ga.binary.manager {
import com.refracta.view.BinaryGeneInformationView;
import com.refracta.view.BlueFilterClip;
import com.refracta.view.RedFilterClip;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.fm.BinaryAddFitnessMeasurment;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.framework.util.Random;
import com.wg.ga.expression.ui.MainUserInterfaceWrapper;

import flash.system.System;

public class BinaryGeneManagerWrapper extends BinaryGeneManager {
	private var mainUserInterface:MainUserInterfaceWrapper;

	public function BinaryGeneManagerWrapper(mainUserInterface:MainUserInterfaceWrapper) {
		this.mainUserInterface = mainUserInterface;
	}

	public function setMutateEntity(mutateLogic:MutationLogic, binaryEntities:Vector.<BinaryEntity>):void {
		for (var i:int = 0; i < binaryEntities.length; i++) {
			if (Random.nextProbability(this.mainUserInterface.getMutationRatio())) {
				var mutation:Entity = mutateLogic.createMutation(binaryEntities[i]);
				binaryEntities[i] = BinaryEntity(mutation);
			}
		}
	}

	public function setMutateEntityWithView(mutateLogic:MutationLogic, binaryEntities:Vector.<BinaryEntity>):Vector.<Vector.<BinaryEntity>> {
		var returnViewVector:Vector.<Vector.<BinaryEntity>> = new <Vector.<BinaryEntity>>[];
		for (var i:int = 0; i < binaryEntities.length; i++) {
			if (Random.nextProbability(this.mainUserInterface.getMutationRatio())) {
				var originalCacheEntity:BinaryEntity = binaryEntities[i];
				var mutationEntity:BinaryEntity = BinaryEntity(mutateLogic.createMutation(binaryEntities[i]));
				binaryEntities[i] = mutationEntity;
				returnViewVector.push(new <BinaryEntity>[originalCacheEntity, mutationEntity]);
			}
		}
		return returnViewVector;
	}

	public function getRandomIndexCrossoverEntities(crossoverLogic:CrossoverLogic, binaryEntities:Vector.<BinaryEntity>):Vector.<BinaryEntity> {
		var childEntities:Vector.<BinaryEntity> = new Vector.<BinaryEntity>();
		var size:int = binaryEntities.length;
		if (size < 2) {
			try {
				throw new Error("BinaryEntity list size is small");
			} catch (e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}
		for (var i:int = 0; i < this.mainUserInterface.getOriginalPoolAmount(); i++) {
			var randomIndex1:int = Random.nextInt(size);
			var randomIndex2:int = Random.nextInt(size);
			for (; randomIndex1 == randomIndex2; randomIndex1 = Random.nextInt(size)) ;
			var source1:BinaryEntity = binaryEntities[randomIndex1];
			var source2:BinaryEntity = binaryEntities[randomIndex2];
			var reproductionEntity:BinaryEntity = BinaryEntity(crossoverLogic.createCrossoverEntity(source1, source2));
			childEntities.push(reproductionEntity);
		}
		return childEntities;
	}

	public function getViewParameterRandomIndexCrossoverEntities(crossoverLogic:CrossoverLogic, binaryEntities:Vector.<BinaryEntity>):Vector.<Vector.<BinaryEntity>> {
		var childEntities:Vector.<Vector.<BinaryEntity>> = new Vector.<Vector.<BinaryEntity>>();
		var size:int = binaryEntities.length;
		if (size < 2) {
			try {
				throw new Error("BinaryEntity list size is small");
			} catch (e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}
		for (var i:int = 0; i < this.mainUserInterface.getOriginalPoolAmount(); i++) {
			var randomIndex1:int = Random.nextInt(size);
			var randomIndex2:int = Random.nextInt(size);
			for (; randomIndex1 == randomIndex2; randomIndex1 = Random.nextInt(size)) ;
			var source1:BinaryEntity = binaryEntities[randomIndex1];
			var source2:BinaryEntity = binaryEntities[randomIndex2];
			var reproductionEntity:BinaryEntity = BinaryEntity(crossoverLogic.createCrossoverEntity(source1, source2));
			childEntities.push(new <BinaryEntity>[source1, source2, reproductionEntity]);

		}
		return childEntities;
	}

	public function getFilteredEntities(entities:Vector.<Vector.<BinaryEntity>>):Vector.<BinaryEntity> {
		var childEntities:Vector.<BinaryEntity> = new Vector.<BinaryEntity>();
		for (var i:int = 0; i < entities.length; i++) {
			childEntities.push(entities[i][2]);
		}
		return childEntities;
	}
}
}
