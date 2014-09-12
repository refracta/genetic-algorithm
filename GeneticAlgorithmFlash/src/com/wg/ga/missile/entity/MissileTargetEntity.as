/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 12:15
 */
package com.wg.ga.missile.entity {
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;
import com.wg.ga.framework.gene.DirectionGene;

public class MissileTargetEntity extends Entity {
	public function MissileTargetEntity(geneInformation:Vector.<DirectionGene>, fitnessMeasurement:FitnessMeasurement) {
		super(Vector.<Gene>(geneInformation), fitnessMeasurement);
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
		return "["+getDirectionString()+"]"+ " (" + Math.round(this.getFitnessMeasurement().getTotalGeneFitness(this)*100)/100 + ")";;
	}
}
}
