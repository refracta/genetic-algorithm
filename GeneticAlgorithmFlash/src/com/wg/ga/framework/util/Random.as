/**
 * 개발자 : refracta
 * 날짜   : 2014-08-08 오전 2:44
 */
package com.wg.ga.framework.util {
public class Random {
	public static function nextInt(limit:int) {
		return Math.floor(Math.random() * limit);
	}

	public static function nextBoolean():Boolean {
		return nextInt(2) == 1 ? true : false;
	}

	public static function nextProbability(probability:Number):Boolean {
		var random:Number = Math.random() * 100;
		if (random <= probability) {
			return true;
		} else {
			return false;
		}
	}
	public static function nextProbabilityByDecimalPercent(decimalPercentProbability:Number):Boolean {
		return nextProbability(decimalPercentProbability*100);
	}
}
}
