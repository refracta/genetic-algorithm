package com.refracta.view {
	
	import flash.display.MovieClip;
	
	
	public class FitnessObject extends MovieClip {
		
		private var _outline:MovieClip = new FitnessObjectOutline();
		public function FitnessObject() {
			this.addChildAt(_outline, 0);
		}

		public function get outline():MovieClip {
			return _outline;
		}

		public function set outline(value:MovieClip):void {
			_outline = value;
		}
	}
	
}
