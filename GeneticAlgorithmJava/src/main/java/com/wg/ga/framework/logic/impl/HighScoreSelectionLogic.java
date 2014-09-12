package com.wg.ga.framework.logic.impl;

import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.framework.entity.Entity;

import java.util.ArrayList;
import java.util.Collections;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 2:13
 */
public class HighScoreSelectionLogic implements SelectionLogic {
	private double persent;

	public HighScoreSelectionLogic(double persent) {
		this.persent = persent;
	}

	public double getPersent() {
		return persent;
	}

	public void setPersent(double persent) {
		this.persent = persent;
	}

	@Override
	public ArrayList<? extends Entity> getSelectGene(ArrayList<? extends Entity> entities) {

		int selectIndex = ((int) (entities.size() * (this.persent / 100.0)));
		Collections.sort(entities, new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER));
		ArrayList<Entity> returnList = new ArrayList<Entity>();
		for (int i = 0; i < selectIndex; i++) {
			returnList.add(entities.get(i));
		}
		return returnList;
	}
}
