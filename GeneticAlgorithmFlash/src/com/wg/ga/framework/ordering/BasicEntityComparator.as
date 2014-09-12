package com.wg.ga.framework.ordering {
import com.wg.ga.framework.entity.Entity;

public class BasicEntityComparator {

	//1 Constructors
	//4 Methods
	//1 Fields


	//Fields
	private var basicOrderingOption:int;


	public function BasicEntityComparator(basicOrderingOption:int) {
		this.basicOrderingOption = basicOrderingOption;
	}

	public function compare(entity1:Entity, entity2:Entity):int {

		if (entity1.getTotalGeneFitness() < entity2.getTotalGeneFitness()) {
			return -1 * basicOrderingOption;
		}
		else if (entity1.getTotalGeneFitness() > entity2.getTotalGeneFitness()) {
			return 1 * basicOrderingOption;
		}
		else {
			return 0 * basicOrderingOption;
		}
	}


}
}