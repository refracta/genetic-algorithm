package com.refracta.view {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class MidnightBlueFlatButton extends MovieClip {
		private var _dynamicButton:DynamicButton;
		public function MidnightBlueFlatButton() {
			this._dynamicButton = new DynamicButton(this,this.buttonTextField);
			
		}
		public function get dynamicButton():DynamicButton{
			return this._dynamicButton;
		}
	}
	
}
