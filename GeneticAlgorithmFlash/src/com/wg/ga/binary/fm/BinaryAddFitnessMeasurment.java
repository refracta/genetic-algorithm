package com.wg.ga.binary.fm;

import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;

import java.util.ArrayList;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 1:52
 */
public class BinaryAddFitnessMeasurment implements FitnessMeasurement {
	@Override
	public double getTotalGeneFitness(Entity entity) {
		BinaryEntity castedEntity = (BinaryEntity) entity;
		ArrayList<BinaryGene> geneInfomation = (ArrayList<BinaryGene>) castedEntity.getGeneInfomation();
		int totalFitness = 0;
		for(Gene gene : geneInfomation){
			BinaryGene castedGene = (BinaryGene) gene;
			totalFitness+=castedGene.getGene();
		}
		return totalFitness;
	}
}
