package com.refracta.view {

import flash.display.MovieClip;

import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.binary.gene.BinaryGene;


public class BinaryGeneInformationView extends MovieClip {
	private var _viewVector:Vector.<MovieClip>;
	private var view:MovieClip;
	public function BinaryGeneInformationView(entity:BinaryEntity, firstLoad:Boolean) {
		_viewVector= getBinaryGeneInfomationViews(entity);
		if(firstLoad){
			reloadViewVector(false);
		}
		this.geneValue.text = entity.getDexNumber() + "";
		this.functionValue.text = entity.getTotalGeneFitness() + "";
	}
	public function reloadViewVector(removePrecView:Boolean){
		if(removePrecView){
			this.removeChild(this.view);
		}
		this.view = new MovieClip();
		this.addChild(this.view);
		for (var t:int = 0; t < _viewVector.length; t++) {
			this.view.addChild(_viewVector[t]);
		}
	}
	public function removeChildView(){
		this.removeChild(this.view);
	}


	public function get viewVector():Vector.<MovieClip> {
		return _viewVector;
	}

	public function getBinaryGeneInfomationViews(entity:BinaryEntity):Vector.<MovieClip> {
		var returnVector:Vector.<BinaryGeneView> = new Vector.<BinaryGeneView>();
		var geneInformation:Vector.<Gene> = entity.getGeneInformation();
		for (var i:int = 0; i < geneInformation.length; i++) {
			var currentGeneView:BinaryGeneView = new BinaryGeneView(BinaryGene(geneInformation[i]).getGene());
			currentGeneView.x = currentGeneView.width * i;
			currentGeneView.y = 0;
			returnVector.push(currentGeneView);
		}
		return Vector.<MovieClip>(returnVector);
	}

	public function setSplitLine(i:uint) {
		var cacheBinaryGene = new BinaryGeneView(0);
		var realIndex:uint = cacheBinaryGene.width * i;
		var line:GeneSplitLine = new GeneSplitLine();
		line.x = realIndex;
		line.y = -1 * ((line.height - cacheBinaryGene.height) / 2);
		this.addChild(line);
	}
}


}
