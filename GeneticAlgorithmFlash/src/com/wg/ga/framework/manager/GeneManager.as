package com.wg.ga.framework.manager {
import com.wg.ga.framework.gene.Gene;

public interface GeneManager {

		//Methods
		function makeRandomUnlimitedGeneList():Vector.<Gene>;

		function makeRandomLimitGeneList(int1:int):Vector.<Gene>;



	}
}