package com.wg.ga.physical.logic.impl {
import com.wg.ga.framework.util.Random;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.physical.entity.BallEntity;

public class BallMutationLogic implements MutationLogic {

	//1 Constructors
	//2 Methods
	//1 Fields


	//Fields
	private var numberOfChangeTry:int;


	//Constructors
	public function BallMutationLogic(numberOfChangeTry:int) {
		this.numberOfChangeTry = numberOfChangeTry;
	}


	//Methods


	public function createMutation(sourceEntity:Entity):Entity {

		var entity:BallEntity = BallEntity(sourceEntity);
		var directionGenes:Vector.<DirectionGene> = new Vector.<DirectionGene>();
		directionGenes = directionGenes.concat(Vector.<DirectionGene>(entity.getGeneInformation()));


		for (var i:int = 0; i < numberOfChangeTry; i++) {
			var size:int = directionGenes.length;
			var randomIndex:int = Random.nextInt(size);
			var removeGeneList:Vector.<DirectionGene> = new Vector.<DirectionGene>().concat(DirectionGene.GENE_LIST);
			removeGeneList.splice(removeGeneList.indexOf(directionGenes[randomIndex]), 1);
			var changeGene:DirectionGene = removeGeneList[Random.nextInt(removeGeneList.length)];
			directionGenes[randomIndex] = changeGene;
		}
		var mutateEntity:BallEntity = new BallEntity(directionGenes);
		trace("MutationLogic : " + BallEntity(sourceEntity).toString() + " -> " + BallEntity(mutateEntity).toString());
		return mutateEntity;
	}


}
}