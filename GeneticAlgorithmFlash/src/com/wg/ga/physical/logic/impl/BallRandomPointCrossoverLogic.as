package com.wg.ga.physical.logic.impl {
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.ReproductionLogic;
import com.wg.ga.framework.util.Random;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.physical.entity.BallEntity;


import flash.system.System;

public class BallRandomPointCrossoverLogic implements CrossoverLogic {


	public function createCrossoverEntity(entity1:Entity, entity2:Entity):Entity {
		var e1:BallEntity = BallEntity(entity1);
		var e2:BallEntity = BallEntity(entity2);
		var genes:Vector.<DirectionGene> = new Vector.<DirectionGene>();
		var splitIndex:int = Random.nextInt(e1.getGeneInformation().length);

		if (e1.getGeneInformation().length <= 1) {
			try {
				throw new Error("BallEntity's geneList size is small");
			} catch (e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		} else {
			for (var i:int = 0; i < splitIndex; i++) {
				genes.push(e1.getGeneInformation()[i]);
			}
			for (var j:int = splitIndex; j < e2.getGeneInformation().length; j++) {
				genes.push(e2.getGeneInformation()[j]);
			}
		}
		var reproduction:BallEntity = new BallEntity(genes);
//		trace("RandomPointCrossoverLogic : "+MissileTargetEntity(e1).toString()+" * "+MissileTargetEntity(e2).toString()+" -> "+reproduction.toString());
		return reproduction;
	}
}
}