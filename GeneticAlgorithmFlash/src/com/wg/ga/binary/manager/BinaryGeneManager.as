package com.wg.ga.binary.manager {
import com.wg.ga.framework.util.Random;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.manager.GeneManager;

public class BinaryGeneManager implements GeneManager  {


		//1 Constructors
		//4 Methods
		//0 Fields
		

		//Fields


		//Constructors


	//Methods


	public function getFirstLimitBinaryEntitys(fitnessMeasurement:FitnessMeasurement, numOfGene:int, numOfEntity:int):Vector.<BinaryEntity> {
		 var entityList:Vector.<BinaryEntity> = new Vector.<BinaryEntity>();
		for (var i:int = 0; i < numOfEntity; i++) {
			entityList.push(getLimitBinaryEntity(fitnessMeasurement,numOfGene));
		}
		return entityList;
}

	public function getLimitBinaryEntity(fitnessMeasurement:FitnessMeasurement, numOfGene:int):BinaryEntity {
		var genes:Vector.<BinaryGene> = Vector.<BinaryGene> (makeRandomLimitGeneList(numOfGene));
		var returnEntity:BinaryEntity = new BinaryEntity(genes,fitnessMeasurement);
		return returnEntity;
	}

  public function makeRandomUnlimitedGeneList():Vector.<Gene> {
		return null;
	}

	 public function makeRandomLimitGeneList(numOfGene:int):Vector.<Gene> {
		 var firstGene:Vector.<BinaryGene> = new Vector.<BinaryGene>();
		for (var i:int  = 0; i < numOfGene; i++) {
			var geneInteger:int = Random.nextBoolean() ? 0 : 1;
			firstGene.push(new BinaryGene(geneInteger));
		}
		return Vector.<Gene>(firstGene);

	}
}
}