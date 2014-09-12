package com.refracta.view {

	import flash.display.MovieClip;


	public class BinaryGeneView extends MovieClip {
		

		public function BinaryGeneView(gene:int) {
			if (gene == 0) {
				this.gotoAndStop(1);
			}else if(gene == 1){
				this.gotoAndStop(2);
			}else{
				this.gotoAndStop(3);
			}
		}
	}

}
