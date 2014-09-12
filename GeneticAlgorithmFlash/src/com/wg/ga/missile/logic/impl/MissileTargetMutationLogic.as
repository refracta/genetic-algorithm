package com.wg.ga.missile.logic.impl {
import com.wg.ga.framework.util.Random;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;

public class MissileTargetMutationLogic implements MutationLogic {

	//1 Constructors
	//2 Methods
	//1 Fields


	//Fields
	private var numberOfChangeTry:int;


	//Constructors
	public function MissileTargetMutationLogic(numberOfChangeTry:int) {
		this.numberOfChangeTry = numberOfChangeTry;
	}


	//Methods



	public function createMutation(sourceEntity:Entity):Entity {

		var missileTargetEntity:MissileTargetEntity = MissileTargetEntity(sourceEntity);
		var directionGenes:Vector.<DirectionGene> = new Vector.<DirectionGene>();
		directionGenes = directionGenes.concat(Vector.<DirectionGene>(missileTargetEntity.getGeneInformation()));

		for (var i:int = 0; i < numberOfChangeTry; i++) {
			var size:int = directionGenes.length;
			var randomIndex:int = Random.nextInt(size);
			var removeGeneList:Vector.<DirectionGene> = new Vector.<DirectionGene>().concat(DirectionGene.GENE_LIST);
			removeGeneList.splice(removeGeneList.indexOf(directionGenes[randomIndex]), 1);
			var changeGene:DirectionGene = removeGeneList[Random.nextInt(removeGeneList.length)];
			directionGenes[randomIndex] = changeGene;
		}
		var mutateEntity:MissileTargetEntity = new MissileTargetEntity(directionGenes, missileTargetEntity.getFitnessMeasurement());
//		trace("MutationLogic : " + MissileTargetEntity(sourceEntity).toString() + " -> " + MissileTargetEntity(mutateEntity).toString());
		return mutateEntity;
	}


}
}