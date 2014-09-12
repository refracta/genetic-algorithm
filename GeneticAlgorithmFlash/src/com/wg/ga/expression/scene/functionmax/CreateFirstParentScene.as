/**
 * 개발자 : refracta
 * 날짜   : 2014-08-11 오전 4:51
 */
package com.wg.ga.expression.scene.functionmax {

import com.refracta.view.BinaryGeneInformationView;
import com.refracta.view.CreateParent;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;

import fl.containers.ScrollPane;
import fl.controls.ScrollPolicy;

import flash.display.MovieClip;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class CreateFirstParentScene extends Scene {
	public function CreateFirstParentScene(entityGroup:Vector.<BinaryEntity>) {
		this.firstEntityGroup = entityGroup;
	}

	private var scrollPane:ScrollPane;
	private var scrollMovieClip:MovieClip;
	private var firstEntityGroup:Vector.<BinaryEntity>;

	override public function init():void {
		var mc:MovieClip = new CreateParent();
		mc.x = 28;
		mc.y = 24;
		this.view.expressionMovieClip.addChild(mc);

		this.scrollPane = new ScrollPane();
//		this.scrollPane.horizontalScrollPolicy= ScrollPolicy.ON;

		this.scrollPane.x = 28;
		this.scrollPane.y = 83;
		this.scrollPane.width = 444;
		this.scrollPane.height = 405;
		this.scrollMovieClip = new MovieClip();

		for (var i:int = 0; i < this.firstEntityGroup.length; i++) {
			var currentInformationView:BinaryGeneInformationView = new BinaryGeneInformationView(this.firstEntityGroup[i],true);
			currentInformationView.y = i * (currentInformationView.height + 5);
			this.scrollMovieClip.addChild(currentInformationView);
		}

		this.scrollPane.source = this.scrollMovieClip;
		this.scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
		this.view.expressionMovieClip.addChild(this.scrollPane);
		var loopIndex = int(this.scrollMovieClip.height / this.scrollPane.height) + 1;
		for (var j:int = 1; j < loopIndex; j++) {
			var updateLogic:Function = function updateScroll(e:View) {
			var t:Timer = new Timer(10,1);
				t.addEventListener(TimerEvent.TIMER, function (ee:TimerEvent){
					scrollPane.verticalScrollBar.scrollPosition = (e.sceneNextChange.indexOf(updateScroll) + 1) * scrollPane.height;
				})
				t.start();
			};
			this.view.sceneNextChange.push(updateLogic);
		}
	}

}
}
