package com.wg.ga.framework.logic.impl {
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;

public class HighScoreSelectionLogic {

	//1 Constructors
	//3 Methods
	//1 Fields


	//Fields
	private var persent:Number;


	//Constructors
	public function HighScoreSelectionLogic(persent:Number) {
			this.persent = persent;
	}

	//Methods
	public function setPersent(persent:Number):void {
		this.persent = persent;
	}

	public function getSelectGene(entities:Vector.<Entity>):Vector.<Entity> {
		var selectIndex:int = ((int)(entities.length * (this.persent / 100.0)));
		var comparator:BasicEntityComparator = new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER);
		entities.sort(comparator.compare);
		var returnList:Vector.<Entity> = new Vector.<Entity>();
		for (var i:int = 0; i < selectIndex; i++) {
			returnList.push(entities[i]);
		}
		return returnList;
	}

	public function getPersent():Number {
		return this.persent;
	}


}
}
