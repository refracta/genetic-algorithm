package com.refracta.view {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObject;


	public class ScrollPaneWrapper extends MovieClip {

		private var xMax: Number = 0;
		private var yMax: Number = 0;
		public function ScrollPaneWrapper() {
			this.addEventListener(Event.ADDED, addEvent);
		}


		function addEvent(e: Event) {
			var containBol: Boolean = true;
			try {
				this.getChildIndex(DisplayObject(e.target));
			} catch (e: Error) {
				containBol = false;
			}
			if (containBol) {
				var targetX: Number = e.target.x + e.target.width;
				var targetY: Number = e.target.y + e.target.height;
				if (this.xMax < targetX) {
					this.wrapper.width = targetX;
					this.xMax = targetX;
				}
				if (this.yMax < targetY) {
					this.wrapper.height = targetY;
					this.yMax = targetY;
				}
			}
		}



	}

}
