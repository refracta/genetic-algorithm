package com.wg.ga.binary.gene;

import com.wg.ga.framework.gene.Gene;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 1:24
 */
public class BinaryGene implements Gene {
	public BinaryGene(int gene) {
		this.gene = gene;
		if (!(gene == 1 || gene == 0)) {
			throwException();
		}
	}

	private int gene = 0;

	public int getGene() {
		if (!(gene == 1 || gene == 0)) {
			throwException();
		} else {
			return gene;
		}
		return -1;
	}

	public void setGene(int gene) {
		if (!(gene == 1 || gene == 0)) {
			throwException();
		} else {
			this.gene = gene;
		}
	}

	public void throwException() {
		try {
			throw new Exception("GeneNumberOutException GeneNumber = " + this.gene);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.exit(1);
	}

	@Override
	public String toString() {
		return ""+gene+"";
	}
}
