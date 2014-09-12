package com.wg.ga.binary.fm;

import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;

import java.util.ArrayList;

/**
 * 개발자 : refracta
 * 날짜   : 2014-07-28 오전 3:26
 */
public class BinaryCalculateFitnessMeasurment implements FitnessMeasurement {
	@Override
	public double getTotalGeneFitness(Entity entity) {
		BinaryEntity binaryEntity = (BinaryEntity) entity;
		return binaryEntity.getDexNumber();
	}
}
