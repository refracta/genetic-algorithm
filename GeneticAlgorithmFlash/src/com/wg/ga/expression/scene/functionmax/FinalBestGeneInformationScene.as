/**
 * 개발자 : refracta
 * 날짜   : 2014-08-13 오전 5:11
 */
package com.wg.ga.expression.scene.functionmax {
import com.refracta.view.BinaryGeneInformationView;
import com.refracta.view.DefaultSizeLabel;
import com.refracta.view.DownArrow;
import com.refracta.view.ScrollPaneWrapper;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;

import fl.containers.ScrollPane;
import fl.controls.ScrollPolicy;

import flash.events.TimerEvent;
import flash.utils.Timer;

public class FinalBestGeneInformationScene extends Scene {
	private var bestEntityGroup:Vector.<BinaryEntity>;
	private var scrollPane:ScrollPane;
	private var scrollMovieClip:ScrollPaneWrapper;

	public function FinalBestGeneInformationScene(bestEntityGroup:Vector.<BinaryEntity>) {
		this.bestEntityGroup = bestEntityGroup;
	}

	override public function init():void {
		this.scrollPane = new ScrollPane();
		this.scrollPane.x = 28;
		this.scrollPane.y = 83;
		this.scrollPane.width = 444;
		this.scrollPane.height = 405;
		this.scrollMovieClip = new ScrollPaneWrapper();


		var selectionLogicLabel:DefaultSizeLabel = new DefaultSizeLabel();
		selectionLogicLabel.setText("각 세대 별 최고 개체 변이 과정");
		selectionLogicLabel.y = 28;
		this.view.expressionMovieClip.addChild(selectionLogicLabel);
		for (var i:int = 0; i < this.bestEntityGroup.length; i++) {
			var generationText = new DefaultSizeLabel();
			generationText.setText(i + "세대 개체");
			generationText.width = this.scrollPane.width-20;
			generationText.y = i * 130;
			var entityView:BinaryGeneInformationView = new BinaryGeneInformationView(this.bestEntityGroup[i], true);
			entityView.y = generationText.y + generationText.height + 10;
			var downArrow:DownArrow = new DownArrow();
			downArrow.x = this.scrollPane.width / 2 - 27;
			downArrow.y = entityView.y + entityView.height - downArrow.height+5;
			this.scrollMovieClip.addChild(generationText);
			this.scrollMovieClip.addChild(entityView);
			if(i+1==this.bestEntityGroup.length){
			}else{
				this.scrollMovieClip.addChild(downArrow);
			}
		}

		this.scrollPane.source = this.scrollMovieClip;
		this.scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
		this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
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
