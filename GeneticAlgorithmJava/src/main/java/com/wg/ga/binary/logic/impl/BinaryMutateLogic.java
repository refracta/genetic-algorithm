package com.wg.ga.binary.logic.impl;

import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.MutateLogic;

import java.util.ArrayList;
import java.util.Random;

/**
 * 개발자 : refracta
 * 날짜   : 2014-07-28 오전 5:18
 */
public class BinaryMutateLogic implements MutateLogic {
	private int numberOfChangeTry;

	public BinaryMutateLogic(int numberOfChangeTry) {
		this.numberOfChangeTry = numberOfChangeTry;
	}

	@Override
	public Entity createMutation(Entity sourceEntity) {
		BinaryEntity binaryEntity = (BinaryEntity) sourceEntity;
		ArrayList<BinaryGene> binaryGenes = new ArrayList<BinaryGene>();
		binaryGenes.addAll((java.util.Collection<BinaryGene>) binaryEntity.getGeneInformation());
		Random random = new Random();
		for (int i = 0; i < numberOfChangeTry; i++) {
			int size = binaryGenes.size();
			int randomIndex = random.nextInt(size);
			BinaryGene changeGene = notCalculationGene(binaryGenes.get(randomIndex).getGene());
			binaryGenes.set(randomIndex, changeGene);
		}
		BinaryEntity mutateEntity = new BinaryEntity(binaryGenes, binaryEntity.getFitnessMeasurement());
		System.out.println("MutateLogic : "+sourceEntity.toString()+" → "+mutateEntity.toString());
		return mutateEntity;
	}

	public BinaryGene notCalculationGene(int source) {
		source = source == 1 ? 0 : 1;
		return new BinaryGene(source);
	}
}
