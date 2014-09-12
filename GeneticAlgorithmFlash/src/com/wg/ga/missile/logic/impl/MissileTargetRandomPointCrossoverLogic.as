package com.wg.ga.missile.logic.impl {
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.ReproductionLogic;
import com.wg.ga.framework.util.Random;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;


import flash.system.System;

public class MissileTargetRandomPointCrossoverLogic implements CrossoverLogic {




		//Methods








	public function createCrossoverEntity(entity1:Entity, entity2:Entity):Entity {
		var missileTargetEntity1:MissileTargetEntity = MissileTargetEntity(entity1) ;
		var missileTargetEntity2:MissileTargetEntity  = MissileTargetEntity (entity2);
		var genes:Vector.<DirectionGene> = new Vector.<DirectionGene>();
		var splitIndex:int  = Random.nextInt(missileTargetEntity1.getGeneInformation().length);

		if(missileTargetEntity1.getGeneInformation().length<=1){
			try {
				throw new Error("BinaryEntity's genelist size is small");
			} catch ( e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}else{
			for (var i:int  = 0; i < splitIndex; i++) {
				genes.push(missileTargetEntity1.getGeneInformation()[i]);
			}
			for (var j:int  = splitIndex; j < missileTargetEntity2.getGeneInformation().length; j++) {
				genes.push(missileTargetEntity2.getGeneInformation()[j]);
			}
		}
		var reproduction:MissileTargetEntity  = new MissileTargetEntity(genes, missileTargetEntity1.getFitnessMeasurement());
//		trace("RandomPointCrossoverLogic : "+MissileTargetEntity(missileTargetEntity1).toString()+" * "+MissileTargetEntity(missileTargetEntity2).toString()+" -> "+reproduction.toString());
		return reproduction;
	}
}
}