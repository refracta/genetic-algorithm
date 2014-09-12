package com.wg.ga.binary.fm {
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;

public class BinaryAddFitnessMeasurment implements FitnessMeasurement {

	//1 Constructors
	//1 Methods
	//0 Fields


	//Fields


	//Constructors



	//Methods

	public function getTotalGeneFitness(entity:Entity):Number {
		var castedEntity:BinaryEntity = BinaryEntity(entity);
		var geneInformation:Vector.<BinaryGene> = Vector.<BinaryGene>(castedEntity.getGeneInformation());
		var totalFitness:int = 0;
		for each(var gene:BinaryGene in geneInformation) {
			totalFitness += gene.getGene();
		}
		return totalFitness;
	}


}
}