package com.wg.ga.framework.ordering;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-05 오전 7:35
 */
public enum BasicOrderingOption {

		ASCENDING_ORDER(1),
		DESCENDING_ORDER(-1);

		final private Integer value;

		BasicOrderingOption(Integer i) {
			value = i;
		}

		public Integer value() {
			return value;
		}

}
