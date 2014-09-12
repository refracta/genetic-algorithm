package com.wg.ga.framework.entity {
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;

import flash.net.registerClassAlias;

import flash.utils.ByteArray;

public class Entity {

	//3 Constructors
	//7 Methods
	//3 Fields


	//Fields
	private var geneInformation:Vector.<Gene>;

	private var fitnessMeasurement:FitnessMeasurement;




	//Constructors


	public function Entity(geneInformation:Vector.<Gene> = null, fitnessMeasurement:FitnessMeasurement = null) {
		if (geneInformation != null) {
			this.geneInformation = geneInformation;
		}
		if (fitnessMeasurement != null) {
			this.fitnessMeasurement = fitnessMeasurement;
		}
	}


	//Methods


	public function getTotalGeneFitness():Number {
		return Math.round(this.fitnessMeasurement.getTotalGeneFitness(this)*100)/100;
	}

	public function getGeneInformation():Vector.<Gene> {
		return this.geneInformation
	}

	public function setGeneInformation(geneInformation:Vector.<Gene>):void {
		this.geneInformation = geneInformation;
	}

	public function setFitnessMeasurement(fitnessMeasurement:FitnessMeasurement):void {
		this.fitnessMeasurement = fitnessMeasurement;
	}



	public function getFitnessMeasurement():FitnessMeasurement {
		return this.fitnessMeasurement;
	}


}
}