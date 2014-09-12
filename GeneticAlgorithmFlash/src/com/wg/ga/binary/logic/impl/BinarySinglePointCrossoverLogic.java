package com.wg.ga.binary.logic.impl;

import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;

import java.util.ArrayList;

/**
 * 개발자 : refracta
 * 날짜   : 2014-07-28 오전 5:10
 */
public class BinarySinglePointCrossoverLogic implements CrossoverLogic {
	@Override
	public Entity createCrossoverEntity(Entity e1, Entity e2) {
		BinaryEntity binaryEntity1 = (BinaryEntity) e1;
		BinaryEntity binaryEntity2 = (BinaryEntity) e2;
		ArrayList<BinaryGene> binaryGenes = new ArrayList<BinaryGene>();
		int halfIndex = (binaryEntity1.getGeneInfomation().size()-1)/2 +1;

		if(binaryEntity1.getGeneInfomation().size()<=1){
			try {
				throw new Exception("BinaryEntity's genelist size is small");
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(1);
			}
		}else{
			for (int i = 0; i < halfIndex; i++) {
				binaryGenes.add((BinaryGene) binaryEntity1.getGeneInfomation().get(i));
			}
			for (int i = halfIndex; i < binaryEntity2.getGeneInfomation().size(); i++) {
				binaryGenes.add((BinaryGene) binaryEntity2.getGeneInfomation().get(i));
			}
		}
		BinaryEntity crossoverEntity = new BinaryEntity(binaryGenes, binaryEntity1.getFitnessMeasurement());
		System.out.println("SinglePointCrossoverLogic : "+e1.toString()+" ◐ "+e2.toString()+" → "+crossoverEntity.toString());
		return crossoverEntity;
	}
}
