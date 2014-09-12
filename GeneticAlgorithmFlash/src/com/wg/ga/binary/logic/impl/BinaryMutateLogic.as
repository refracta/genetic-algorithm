package com.wg.ga.binary.logic.impl {
import com.wg.ga.framework.util.Random;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.MutationLogic;

public class BinaryMutateLogic implements MutationLogic {

	//1 Constructors
	//2 Methods
	//1 Fields


	//Fields
	private var numberOfChangeTry:int;


	//Constructors
	public function BinaryMutateLogic(numberOfChangeTry:int) {
		this.numberOfChangeTry = numberOfChangeTry;
	}


	//Methods

	public function notCalculationGene(source:int):BinaryGene {
		source = source == 1 ? 0 : 1;
		return new BinaryGene(source);
	}

	public function createMutation(sourceEntity:Entity):Entity {

		var binaryEntity:BinaryEntity = BinaryEntity(sourceEntity);
		var binaryGenes:Vector.<BinaryGene> = new Vector.<BinaryGene>();
		binaryGenes = binaryGenes.concat(Vector.<BinaryGene>(binaryEntity.getGeneInformation()));


		for (var i:int = 0; i < numberOfChangeTry; i++) {
			var size:int = binaryGenes.length;
			var randomIndex:int = Random.nextInt(size);
			var changeGene:BinaryGene = notCalculationGene(binaryGenes[randomIndex].getGene());
			binaryGenes[randomIndex] = changeGene;
		}
		var mutateEntity:BinaryEntity = new BinaryEntity(binaryGenes, binaryEntity.getFitnessMeasurement());
		trace("MutationLogic : " + BinaryEntity(sourceEntity).toString() + " -> " + BinaryEntity(mutateEntity).toString());
		return mutateEntity;
	}


}
}