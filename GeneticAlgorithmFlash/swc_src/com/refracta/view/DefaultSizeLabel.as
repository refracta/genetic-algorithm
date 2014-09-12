package com.refracta.view {
	
	import flash.display.MovieClip;
	
	
	public class DefaultSizeLabel extends MovieClip {
		
		
	public function setText(s:String){
			this.labelTextField.text = s;
		}
		public function setLabelWidth(widthSize:Number){
			this.labelTextField.width = widthSize;
		}
			public function setLabelHeight(heightSize:Number){
			this.labelTextField.height = heightSize;
		}
	}
	
}
