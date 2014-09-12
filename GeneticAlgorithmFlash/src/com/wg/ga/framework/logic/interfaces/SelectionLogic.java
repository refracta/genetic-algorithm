package com.wg.ga.framework.logic.interfaces;

import com.wg.ga.framework.entity.Entity;

import java.util.ArrayList;

/**
 * 개발자 : 이상훈
 * 날짜   : 14. 4. 2 오전 12:09
 */
public interface SelectionLogic {
	public ArrayList<? extends Entity> getSelectGene(ArrayList<? extends Entity> entities);
}
