package com.wg.ga.framework.manager;

import com.wg.ga.framework.gene.Gene;

import java.util.ArrayList;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 1:22
 */
public abstract class GeneManager {
	public abstract ArrayList<? extends Gene> makeRandomLimitGeneList(int numOfGene);

	public abstract ArrayList<? extends Gene> makeRandomUnlimitGeneList();


}
