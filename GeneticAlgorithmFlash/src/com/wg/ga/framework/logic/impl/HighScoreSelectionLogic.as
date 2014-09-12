package com.wg.ga.framework.logic.impl {
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;

public class HighScoreSelectionLogic implements SelectionLogic{

	//1 Constructors
	//3 Methods
	//1 Fields


	//Fields
	private var percent:Number;


	//Constructors
	public function HighScoreSelectionLogic(percent:Number) {
			this.percent = percent;
	}

	//Methods
	public function setPercent(percent:Number):void {
		this.percent = percent;
	}
	public function getSelectGene(entities:Vector.<Entity>):Vector.<Entity> {
		var selectIndex:int = ((int)(entities.length * (this.percent / 100.0)));
		var comparator:BasicEntityComparator = new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER);
		entities.sort(comparator.compare);
		var returnList:Vector.<Entity> = new Vector.<Entity>();
		for (var i:int = 0; i < selectIndex; i++) {
			returnList.push(entities[i]);
		}
		return returnList;
	}

	public function getPercent():Number {
		return this.percent;
	}


}
}
