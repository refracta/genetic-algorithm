package com.wg.ga.binary.fm {
import bkde.as3.parsers.CompiledObject;
import bkde.as3.parsers.MathParser;

import com.wg.ga.binary.entity.BinaryEntity;

import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;

import flash.system.System;

public class BinaryFunctionFitnessMeasurment implements FitnessMeasurement {

	//1 Constructors
	//1 Methods
	//1 Fields


	//Fields
	private var mathScriptFunction:String = null;


	//Constructors
	public function BinaryFunctionFitnessMeasurment(mathScriptFunction:String) {
		this.mathScriptFunction = mathScriptFunction;
	}


	//Methods
	public function getTotalGeneFitness(entity:Entity):Number {
		var binaryEntity:BinaryEntity = BinaryEntity(entity);
		var procFun:MathParser = new MathParser(["x"]);
		var compObj:CompiledObject = procFun.doCompile(this.mathScriptFunction);

		if (compObj.errorStatus == 1) {
			try {
				throw new Error("함수 스크립트에 에러가 있습니다." + "'" + this.mathScriptFunction + "'");
			} catch (e:Error) {
				trace(e.getStackTrace());
				System.exit(1);
			}
		}
		var yNum:Number = procFun.doEval(compObj.PolishArray, [binaryEntity.getDexNumber()]);
		return yNum;
	}


}
}