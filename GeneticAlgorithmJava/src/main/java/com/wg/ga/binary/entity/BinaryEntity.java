package com.wg.ga.binary.entity;

import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;

import java.util.ArrayList;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 1:51
 */
public class BinaryEntity extends Entity {
	public BinaryEntity(ArrayList<BinaryGene> geneInformation, FitnessMeasurement fitnessMeasurement) {
		super(geneInformation, fitnessMeasurement);
	}

	public BinaryEntity(ArrayList<BinaryGene> geneInformation) {
		super(geneInformation);
	}

	public BinaryEntity(FitnessMeasurement fitnessMeasurement) {
		super(fitnessMeasurement);
	}

	@Override
	public String toString() {
		return getBinaryGeneInformationString()+"["+getDexNumber()+"]" + " (" + this.getFitnessMeasurement().getTotalGeneFitness(this) + ")";
	}

	public String getBinaryGeneInformationString() {

		StringBuffer returnStrBuf = new StringBuffer();
		for (int i = 0; i < this.getGeneInformation().size(); i++) {
			BinaryGene castedGene = (BinaryGene) this.getGeneInformation().get(i);
			returnStrBuf.append(castedGene.getGene());
		}
		return returnStrBuf.toString();
	}

	public int getDexNumber(){

		int binaryBuffer = 0;
		int counter = 0;
		for (int i = getGeneInformation().size() - 1; i > -1; i--) {
			int currentGene = ((BinaryGene) getGeneInformation().get(i)).getGene();
			boolean isNotEmpty = currentGene == 0 ? false : true;
			if (isNotEmpty) {
				binaryBuffer += Math.pow(2, counter);
			}
			counter++;
		}
		return binaryBuffer;
	}



}
