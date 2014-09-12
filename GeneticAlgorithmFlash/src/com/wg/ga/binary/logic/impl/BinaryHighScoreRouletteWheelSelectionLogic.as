/**
 * 개발자 : refracta
 * 날짜   : 2014-08-09 오후 9:17
 */
package com.wg.ga.binary.logic.impl {
import com.bit101.charts.PieChart;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.framework.util.CloneUtil;
import com.wg.ga.framework.util.Random;

import flash.display.MovieClip;

public class BinaryHighScoreRouletteWheelSelectionLogic implements SelectionLogic {
	private var _percent:Number;
	private var _deduplication:Boolean;

	public function BinaryHighScoreRouletteWheelSelectionLogic(percent:Number, deduplication:Boolean) {
		this._percent = percent;
		this._deduplication = deduplication;
	}

	public function get percent():Number {
		return _percent;
	}

	public function set percent(value:Number):void {
		_percent = value;
	}

	public function sortVector(entities:Vector.<Entity>) {
		var comparator:BasicEntityComparator = new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER);
		entities.sort(comparator.compare);
	}

	public function getPieChart(entities:Vector.<BinaryEntity>,mc:MovieClip=null) {
		sortVector(Vector.<Entity>(entities));
		var baseNumber:Number = getBaseNumber(Vector.<Entity>(entities));
		var entityTotal:Number = getEntityTotal(Vector.<Entity>(entities));
		var chartArray:Array = new Array();
		for (var i:int = 0; i < entities.length; i++) {
			var fPercent:Number = getFitnessPercent(entities[i], baseNumber, entityTotal);
			fPercent = (Math.round(fPercent* 10000)) / 100;
			var currentEntity:BinaryEntity =entities[i];
			var expression:String = currentEntity.getDexNumber()+" ["+currentEntity.getTotalGeneFitness()+"]("+fPercent+"%)";
			chartArray[i] = {value:fPercent,label:expression};
		}
		var returnPieChart:PieChart = new PieChart(mc, 0, 0,chartArray);
		returnPieChart.autoScale=true;
		return returnPieChart;
	}


	public function getSelectGene(entities:Vector.<Entity>):Vector.<Entity> {
		var selectIndex:int = ((int)(entities.length * (this.percent / 100.0)));
		sortVector(entities);
		var returnVectorArray:Vector.<Entity> = new Vector.<Entity>();
		var baseNumber:Number = getBaseNumber(entities);
		var entityTotal:Number = getEntityTotal(entities);

		if (_deduplication) {
			for (var i:int = 0; i < selectIndex; i++) {
				var selectEntity:Entity = getRoulettePlay(entities, baseNumber, entityTotal);
				returnVectorArray.push(selectEntity);
				entities.splice(entities.indexOf(selectEntity), 1);
				baseNumber = getBaseNumber(entities);
				entityTotal = getEntityTotal(entities);
			}
		} else {
			for (var i:int = 0; i < selectIndex; i++) {
				var selectEntity:Entity = getRoulettePlay(entities, baseNumber, entityTotal);
				returnVectorArray.push(selectEntity);
			}
		}
		return returnVectorArray;
	}


	private function getRoulettePlay(entities:Vector.<Entity>, baseNumber:Number, entityTotal:Number):Entity {
		var rand:Number = Math.random() * 100;
		var randLoop:Number = 0;

		for (var i:int = 0; i < entities.length; i++) {
			var currentFitnessPercent:Number = getFitnessPercent(entities[i], baseNumber, entityTotal) * 100;
			randLoop += currentFitnessPercent;
			if (rand <= randLoop) {

				var castedEntity:BinaryEntity = BinaryEntity(entities[i]);
				var copyInformation:Vector.<BinaryGene> = new Vector.<BinaryGene>();
				for (var j:int = 0; j < castedEntity.getGeneInformation().length; j++) {
					var castedGene:BinaryGene = BinaryGene(castedEntity.getGeneInformation()[j]);
					copyInformation.push(new BinaryGene(castedGene.getGene()));
				}
				var newEntity:BinaryEntity = new BinaryEntity(copyInformation, castedEntity.getFitnessMeasurement());
				return newEntity;
			}
		}
		trace("IT's NULL");
		return null;
	}

	private function getEntityTotal(entities:Vector.<Entity>) {
		var baseNumber = getBaseNumber(entities);
		var entityTotal:Number = 0;
		for (var i:int = 0; i < entities.length; i++) {
			entityTotal += (entities[i].getTotalGeneFitness() + baseNumber);
		}
		return entityTotal;
	}

	private function getBaseNumber(entities:Vector.<Entity>) {
		return Math.abs(entities[entities.length - 1].getTotalGeneFitness()) * 2;
	}

	private function getFitnessPercent(entity:Entity, baseNumber:Number, entityTotal:Number):Number {
		return (entity.getTotalGeneFitness() + baseNumber) / entityTotal;

	}
}
}
