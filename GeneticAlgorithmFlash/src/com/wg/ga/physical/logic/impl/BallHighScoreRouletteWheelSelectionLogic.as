/**
 * 개발자 : refracta
 * 날짜   : 2014-08-09 오후 9:17
 */
package com.wg.ga.physical.logic.impl {
import com.bit101.charts.PieChart;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.framework.util.CloneUtil;
import com.wg.ga.framework.util.Random;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.physical.entity.BallEntity;

import flash.display.MovieClip;

public class BallHighScoreRouletteWheelSelectionLogic implements SelectionLogic {
	private var _percent:Number;
	private var _deduplication:Boolean;

	public function BallHighScoreRouletteWheelSelectionLogic(percent:Number, deduplication:Boolean) {
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

				var castedEntity:BallEntity = BallEntity(entities[i]);
				var copyInformation:Vector.<DirectionGene> = new Vector.<DirectionGene>();
				for (var j:int = 0; j < castedEntity.getGeneInformation().length; j++) {
					var castedGene:DirectionGene = DirectionGene(castedEntity.getGeneInformation()[j]);
					copyInformation.push(castedGene);
				}
				var newEntity:BallEntity = new BallEntity(copyInformation);
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
