package com.wg.ga.framework.ordering;

import com.wg.ga.framework.entity.Entity;

import java.util.Comparator;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 2:30
 */
public class BasicEntityComparator implements Comparator<Entity> {
	private BasicOrderingOption basicOrderingOption;

	public BasicOrderingOption getBasicOrderingOption() {
		return basicOrderingOption;
	}

	public void setBasicOrderingOption(BasicOrderingOption basicOrderingOption) {
		this.basicOrderingOption = basicOrderingOption;
	}

	public BasicEntityComparator(BasicOrderingOption basicOrderingOption) {
		this.basicOrderingOption = basicOrderingOption;
	}
//
	@Override
	public int compare(Entity o1, Entity o2) {
		return this.basicOrderingOption.value() * Double.compare(o1.getFitnessMeasurement().getTotalGeneFitness(o1), o2.getFitnessMeasurement().getTotalGeneFitness(o2));
	}

}
