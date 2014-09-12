/**
 * 개발자 : refracta
 * 날짜   : 2014-08-11 오후 1:13
 */
package com.wg.ga.framework.logic.interfaces {
import com.wg.ga.framework.entity.Entity;

public interface CrossoverLogic {
	 function createCrossoverEntity(e1:Entity, e2:Entity):Entity;
}
}
