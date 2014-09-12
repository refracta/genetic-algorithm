/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 12:15
 */
package com.wg.ga.physical.entity {
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.gene.DirectionGene;

import flash.system.System;

public class BallEntity extends Entity {
	private var _totalGeneFitness:Number= NaN;
	public function BallEntity(geneInformation:Vector.<DirectionGene>) {
		super(Vector.<Gene>(geneInformation), null);
	}

	public function getDirectionString():String {
		var geneInformation:Vector.<DirectionGene> = Vector.<DirectionGene>(getGeneInformation());
		var sb:String = "";
		for (var i:int = 0; i < geneInformation.length; i++) {
			var gene:DirectionGene = geneInformation[i];
			sb = sb.concat(gene.getSimpleSign());
		}
		return sb;
	}

	public function toString():String {
		return "["+getDirectionString()+"]"+ " (" + Math.round(this.getTotalGeneFitness()*100)/100 + ")";;
	}

	override public function getTotalGeneFitness():Number {
//		trace("[=Duplicate=] Redirect to getBallGeneFitness()");
		return getBallGeneFitness();

	}
	public function getBallGeneFitness():Number{
		return this._totalGeneFitness;
	}

	public function set totalGeneFitness(value:Number):void {
		_totalGeneFitness = value;
	}



	override public function getFitnessMeasurement():FitnessMeasurement {
		throw new Error("BallEntity don't have FM");
		System.exit(1);
	}
}
}
