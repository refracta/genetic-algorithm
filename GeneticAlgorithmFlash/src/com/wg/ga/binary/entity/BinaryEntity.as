package com.wg.ga.binary.entity {
import com.wg.ga.binary.gene.BinaryGene;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.framework.gene.Gene;

import flash.utils.ByteArray;

public class BinaryEntity extends Entity {

	//3 Constructors
	//3 Methods
	//0 Fields


	//Fields


	//Constructors


	public function BinaryEntity(geneInformation:Vector.<BinaryGene>, fitnessMeasurement:FitnessMeasurement) {
		super(Vector.<Gene>(geneInformation), fitnessMeasurement);
	}


	//Methods
	public function toString():String {
		return getBinaryGeneInformationString()+"["+Math.round(getDexNumber()*100)/100+"]" + " (" + Math.round(this.getFitnessMeasurement().getTotalGeneFitness(this)*100)/100 + ")";
	}

	public function toSimpleString():String {
		return Math.round(getDexNumber()*100)/100+"" + " (" + Math.round(this.getFitnessMeasurement().getTotalGeneFitness(this)*100)/100 + ")";
	}
	public function getDexNumber():int {
		var binaryBuffer:int = 0;
		var counter:int = 0;
		for (var i:int = getGeneInformation().length - 1; i > -1; i--) {
			var currentGene:int = BinaryGene(getGeneInformation()[i]).getGene();
			var isNotEmpty:Boolean = currentGene == 0 ? false : true;
			if (isNotEmpty) {
				binaryBuffer += Math.pow(2, counter);
			}
			counter++;
		}
		return binaryBuffer;
	}

	public function getBinaryGeneInformationString():String {
		var returnStrBuf:String = "";
		for (var i:int = 0; i < this.getGeneInformation().length; i++) {
			var castedGene:BinaryGene = BinaryGene(this.getGeneInformation()[i]);
			returnStrBuf = returnStrBuf.concat(castedGene.getGene());
		}
		return returnStrBuf;
	}


}
}