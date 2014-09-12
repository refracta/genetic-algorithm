/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 12:55
 */
package com.wg.ga.missile.manager {
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.framework.manager.GeneManager;
import com.wg.ga.framework.util.Random;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;

import flash.system.System;

public class MissileTargetGeneManager implements GeneManager {

	private var originalPoolAmount:int ;
	private var mutationRatio:int ;

	public function MissileTargetGeneManager(originalPoolAmount:int, mutationRatio:int) {
		this.originalPoolAmount = originalPoolAmount;
		this.mutationRatio = mutationRatio;
	}

	public function getRandomIndexCrossoverEntities(crossoverLogic:CrossoverLogic, entities:Vector.<MissileTargetEntity>):Vector.<MissileTargetEntity> {
		var childEntities:Vector.<MissileTargetEntity> = new Vector.<MissileTargetEntity>();
		var size:int = entities.length;
		if (size < 2) {
			try {
				throw new Error("MissileTargetEntity list size is small");
			} catch (e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}
		for (var i:int = 0; i <originalPoolAmount; i++) {
			var randomIndex1:int = Random.nextInt(size);
			var randomIndex2:int = Random.nextInt(size);
			for (; randomIndex1 == randomIndex2; randomIndex1 = Random.nextInt(size)) ;
			var source1:MissileTargetEntity = entities[randomIndex1];
			var source2:MissileTargetEntity = entities[randomIndex2];
			var reproductionEntity:MissileTargetEntity = MissileTargetEntity(crossoverLogic.createCrossoverEntity(source1, source2));
			childEntities.push(reproductionEntity);
		}
		return childEntities;
	}
	public function setMutateEntity(mutateLogic:MutationLogic, targetEntities:Vector.<MissileTargetEntity>):void {
		for (var i:int = 0; i < targetEntities.length; i++) {
			if (Random.nextProbability(mutationRatio)) {
				var mutation:Entity = mutateLogic.createMutation(targetEntities[i]);
				targetEntities[i] = MissileTargetEntity(mutation);
			}
		}
	}


	public function makeRandomUnlimitedGeneList():Vector.<Gene> {
		return null;
	}

	public function makeRandomLimitGeneList(limit:int):Vector.<Gene> {
		var geneInformation:Vector.<DirectionGene> = new Vector.<DirectionGene>();
		for (var i:int = 0; i < limit; i++) {
			geneInformation.push(DirectionGene.GENE_LIST[Random.nextInt(DirectionGene.GENE_LIST.length)]);
		}
		return Vector.<Gene>(geneInformation);
	}
	public function getFirstLimitBinaryEntitys(fitnessMeasurement:FitnessMeasurement, numOfGene:int, numOfEntity:int):Vector.<MissileTargetEntity> {
	var entityList:Vector.<MissileTargetEntity> = new Vector.<MissileTargetEntity>();
		for (var i:int = 0; i < numOfEntity; i++) {
			entityList.push(getLimitMissileTargetEntity(fitnessMeasurement,numOfGene));
		}
		return entityList;
	}
	public function getLimitMissileTargetEntity(fitnessMeasurement:FitnessMeasurement, numOfGene:int):MissileTargetEntity{
		var genes:Vector.<DirectionGene> = Vector.<DirectionGene> (makeRandomLimitGeneList(numOfGene));
		var returnEntity:MissileTargetEntity = new MissileTargetEntity(genes,fitnessMeasurement);
		return returnEntity;
	}
}
}
