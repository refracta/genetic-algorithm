package com.wg.ga.framework.entity {
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;

public class Entity {

	//3 Constructors
	//7 Methods
	//3 Fields


	//Fields
	private var geneInfomation:Vector.<Gene>;

	private var fitnessMeasurement:FitnessMeasurement;

	private var generation:int;


	//Constructors


	public function Entity(geneInfomation:Vector.<Gene>, fitnessMeasurement:FitnessMeasurement = null) {
		if (geneInfomation != null) {
			this.geneInfomation = geneInfomation;
		}
		if (fitnessMeasurement != null) {
			this.fitnessMeasurement = fitnessMeasurement;
		}
	}


	//Methods
	public function setGeneration(generation:int):void {
		this.generation = generation;
	}

	public function getTotalGeneFitness():Number {
		return this.fitnessMeasurement.getTotalGeneFitness(this);
	}

	public function getGeneInfomation():Vector.<Gene> {
		return this.geneInfomation
	}

	public function setGeneInfomation(geneInfomation:Vector.<Gene>):void {
		this.geneInfomation = geneInfomation;
	}

	public function setFitnessMeasurement(fitnessMeasurement:FitnessMeasurement):void {
		this.fitnessMeasurement = fitnessMeasurement;
	}

	public function getGeneration():int {
		return this.generation;
	}

	public function getFitnessMeasurement():FitnessMeasurement {
		return this.fitnessMeasurement;
	}


}
}