package com.wg.ga.framework.entity;

import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.fm.FitnessMeasurement;

import java.util.ArrayList;

/**
 * 개발자 : 이상훈
 * 날짜   : 14. 4. 1 오후 11:37
 */
//IntersectionLogic= 유전자 교차
//MutationLogic= 유전자 변이
//
public class Entity {
	private ArrayList<? extends Gene> geneInfomation;
	private FitnessMeasurement fitnessMeasurement;

	public int getGeneration() {
		return generation;
	}

	public void setGeneration(int generation) {
		this.generation = generation;
	}

	private int generation = 1;

	public Entity(ArrayList<? extends Gene> geneInfomation, FitnessMeasurement fitnessMeasurement) {
		this.fitnessMeasurement = fitnessMeasurement;
		this.geneInfomation = geneInfomation;
	}
	public double getTotalGeneFitness(){
		return this.fitnessMeasurement.getTotalGeneFitness(this);
	}

	public Entity(ArrayList<? extends Gene> geneInfomation) {
		this.geneInfomation = geneInfomation;
	}

	public Entity(FitnessMeasurement fitnessMeasurement) {
		this.fitnessMeasurement = fitnessMeasurement;
	}

	public ArrayList<? extends Gene> getGeneInfomation() {
		return geneInfomation;
	}

	public void setGeneInfomation(ArrayList<? extends Gene> geneInfomation) {
		this.geneInfomation = geneInfomation;
	}

	public FitnessMeasurement getFitnessMeasurement() {
		return fitnessMeasurement;
	}

	public void setFitnessMeasurement(FitnessMeasurement fitnessMeasurement) {
		this.fitnessMeasurement = fitnessMeasurement;
	}
}
