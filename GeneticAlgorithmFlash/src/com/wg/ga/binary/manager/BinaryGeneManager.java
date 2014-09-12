package com.wg.ga.binary.manager;

import com.wg.ga.framework.manager.GeneManager;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.fm.FitnessMeasurement;

import java.util.ArrayList;
import java.util.Random;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 1:28
 */
public class BinaryGeneManager extends GeneManager {
	@Override
	public ArrayList<? extends Gene> makeRandomLimitGeneList(int numOfGene) {
		ArrayList<BinaryGene> firstGene = new ArrayList<BinaryGene>();
		for (int i = 0; i < numOfGene; i++) {
			int geneInteger = new Random().nextBoolean() ? 0 : 1;
			firstGene.add(new BinaryGene(geneInteger));
		}
		return firstGene;
	}

	@Override
	public ArrayList<? extends Gene> makeRandomUnlimitGeneList() {
		return null;
	}

	public BinaryEntity getLimitBinaryEntity(FitnessMeasurement fitnessMeasurement, int numOfGene){
		ArrayList<BinaryGene> genes = (ArrayList<BinaryGene>) makeRandomLimitGeneList(numOfGene);
		BinaryEntity returnEntity = new BinaryEntity(genes,fitnessMeasurement);
		return returnEntity;
	}

	public ArrayList<BinaryEntity> getFirstLimitBinaryEntitys(FitnessMeasurement fitnessMeasurement, int numOfGene,int numOfEntity){
		ArrayList<BinaryEntity> entityList = new ArrayList<BinaryEntity>();
		for (int i = 0; i < numOfEntity; i++) {
			entityList.add(getLimitBinaryEntity(fitnessMeasurement,numOfGene));
		}
		return entityList;
	}

}
