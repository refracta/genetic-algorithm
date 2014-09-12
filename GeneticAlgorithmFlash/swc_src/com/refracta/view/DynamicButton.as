package com.refracta.view {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class DynamicButton {
	private var innerTextField:TextField;
	private var buttonClip:MovieClip;
	private var listenerVector:Vector.<Function> = new Vector.<Function>();
	private var enable:Boolean = true;
	private var currentObjectReference:DynamicButton = DynamicButton(this);

	public function isEnable():Boolean {
		return this.enable;
	}

	public function setEnable(enable:Boolean) {
		this.enable = enable;
	}


	public function setButtonText(buttonText:String) {
		this.innerTextField.text = buttonText;
	}

	public function DynamicButton(movieClip:MovieClip, innderTextField:TextField) {
		this.innerTextField = innderTextField;
		this.buttonClip = movieClip;
		defaultInitButton();
	}

	public function defaultInitButton() {
		this.buttonClip.stop();
		this.buttonClip.buttonMode = true;
		this.innerTextField.selectable = false;
		this.innerTextField.mouseEnabled = false;
		listen();
	}

	public function addEventButtonListener(f:Function) {
		listenerVector.push(f);

	}

	public function removeEventButtonListener(f:Function) {
		listenerVector.splice(listenerVector.indexOf(f), 1);
	}

	private function listen():void {
		this.buttonClip.addEventListener(MouseEvent.MOUSE_OVER, function (e:Event) {
					if (enable) {
						buttonClip.gotoAndStop(2);
					}
				}
		);
		this.buttonClip.addEventListener(MouseEvent.MOUSE_DOWN, function (e:Event) {
					if (enable) {
						buttonClip.gotoAndStop(3);
					}
				}
		);
		this.buttonClip.addEventListener(MouseEvent.MOUSE_UP, function (e:Event) {
					buttonClip.gotoAndStop(1);
					if (enable) {
						for (var i:int = 0; i < listenerVector.length; i++) {
							listenerVector[i](currentObjectReference);
						}
					}
				}
		);
		this.buttonClip.addEventListener(MouseEvent.MOUSE_OUT, function (e:Event) {
			buttonClip.gotoAndStop(1);
		});
	}
}
}
