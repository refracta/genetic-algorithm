package com.wg.ga.binary.fm {
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;

public class BinaryCalculateFitnessMeasurment implements FitnessMeasurement {

	//1 Constructors
	//1 Methods
	//0 Fields


	//Fields


	//Methods

	public function getTotalGeneFitness(entity:Entity):Number {
		var binaryEntity:BinaryEntity = BinaryEntity(entity);
		return binaryEntity.getDexNumber();
	}


}
}