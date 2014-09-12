package com.wg.ga.binary.logic.impl {
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.ReproductionLogic;
import com.wg.ga.framework.util.Random;


import flash.system.System;

public class BinarySinglePointCrossoverLogic implements CrossoverLogic {




		//Methods



	public function getHalfIndex(geneLength:Number){
		var halfIndex:int  = (geneLength-1)/2 +1;
		return halfIndex;
	}





	public function createCrossoverEntity(entity1:Entity, entity2:Entity):Entity {
		var binaryEntity1:BinaryEntity = BinaryEntity(entity1) ;
		var binaryEntity2:BinaryEntity  = BinaryEntity (entity2);
		var binaryGenes:Vector.<BinaryGene> = new Vector.<BinaryGene>();
		var splitIndex:int  = getHalfIndex(entity1.getGeneInformation().length);

		if(binaryEntity1.getGeneInformation().length<=1){
			try {
				throw new Error("BinaryEntity's genelist size is small");
			} catch ( e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}else{
			for (var i:int  = 0; i < splitIndex; i++) {
				binaryGenes.push(BinaryGene(binaryEntity1.getGeneInformation()[i]));
			}
			for (var j:int  = splitIndex; j < binaryEntity2.getGeneInformation().length; j++) {
				binaryGenes.push(BinaryGene(binaryEntity2.getGeneInformation()[j]));
			}
		}
		var reproduction:BinaryEntity  = new BinaryEntity(binaryGenes, binaryEntity1.getFitnessMeasurement());
		trace("SinglePointReproductionLogic : "+BinaryEntity(entity1).toString()+" * "+BinaryEntity(entity2).toString()+" -> "+reproduction.toString());
		return reproduction;
	}
}
}