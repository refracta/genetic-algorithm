package com.wg.ga.binary.gene {
import com.wg.ga.framework.gene.Gene;

import flash.system.System;

public class BinaryGene implements Gene {

		//1 Constructors
		//4 Methods
		//1 Fields
		

		//Fields
		private var gene:int = 0;



		//Constructors
		public function BinaryGene(gene:int) {
			this.gene = gene;
			if (!(gene == 1 || gene == 0)) {
				throwException();
			}
		}



		//Methods


		 public function toString():String {
				return ""+gene;
		}

		public function getGene():int {
			if (!(gene == 1 || gene == 0)) {
				throwException();
			} else {
				return gene;
			}
			return -1;
		}

		public function throwException():void {
			try {
				throw new Error("GeneNumberOutException GeneNumber = " + this.gene);
			} catch (e:Error) {
				trace(e.getStackTrace());
			}
			System.exit(1);
		}



	}
}