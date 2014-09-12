/**
 * 개발자 : refracta
 * 날짜   : 2014-08-13 오전 2:43
 */
package com.wg.ga.expression.scene.functionmax {
import com.refracta.view.BinaryGeneInformationView;
import com.refracta.view.BlueFilterClip;
import com.refracta.view.DefaultSizeLabel;
import com.refracta.view.DownArrow;
import com.refracta.view.RedFilterClip;
import com.refracta.view.ScrollPaneWrapper;
import com.refracta.view.SplitLine;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;

import fl.containers.ScrollPane;
import fl.controls.ScrollPolicy;

import flash.events.TimerEvent;

import flash.utils.Timer;

public class MutationScene extends Scene {
	private var mutationData:Vector.<Vector.<BinaryEntity>>;
	private var scrollPane:ScrollPane;
	private var scrollMovieClip:ScrollPaneWrapper;

	public function MutationScene(mutationData:Vector.<Vector.<BinaryEntity>>) {
		this.mutationData = mutationData;
	}

	override public function init():void {
		this.scrollPane = new ScrollPane();
		this.scrollPane.x = 28;
		this.scrollPane.y = 83;
		this.scrollPane.width = 444;
		this.scrollPane.height = 405;
		this.scrollMovieClip = new ScrollPaneWrapper();

		var selectionLogicLabel:DefaultSizeLabel = new DefaultSizeLabel();
		selectionLogicLabel.setText("(재생산 과정) 돌연변이 로직");
		selectionLogicLabel.y = 28;
		this.view.expressionMovieClip.addChild(selectionLogicLabel);
		if (mutationData.length == 0) {
			var failLabel:DefaultSizeLabel = new DefaultSizeLabel();
			failLabel.setText("돌연변이가 일어나지 않았습니다.");
			failLabel.y = selectionLogicLabel.y * 3;
			this.view.expressionMovieClip.addChild(failLabel);
		}

		for (var i:int = 0; i < mutationData.length; i++) {
			var originalEntity:BinaryEntity = mutationData[i][0];
			var mutationEntity:BinaryEntity = mutationData[i][1];
			var originalView:BinaryGeneInformationView = new BinaryGeneInformationView(originalEntity, false);
			var mutationView:BinaryGeneInformationView = new BinaryGeneInformationView(mutationEntity, false);
			var changeIndex:Vector.<int> = new <int>[];
			for (var j:int = 0; j < originalEntity.getGeneInformation().length; j++) {
				if (originalEntity.getGeneInformation()[j] != mutationEntity.getGeneInformation()[j]) {
					changeIndex.push(j);
				}
			}
			for (var k:int = 0; k < changeIndex.length; k++) {
				var blueFilter:BlueFilterClip = new BlueFilterClip();
				blueFilter.viewClip.addChild(originalView.viewVector[changeIndex[k]]);
				originalView.viewVector[changeIndex[k]] = blueFilter;
				var blueFilter:BlueFilterClip = new BlueFilterClip();
				blueFilter.viewClip.addChild(originalView.viewVector[changeIndex[k]]);
				originalView.viewVector[changeIndex[k]] = blueFilter;
				var redFilter:RedFilterClip = new RedFilterClip();
				redFilter.viewClip.addChild(mutationView.viewVector[changeIndex[k]]);
				mutationView.viewVector[changeIndex[k]] = redFilter;
				var redFilter:RedFilterClip = new RedFilterClip();
				redFilter.viewClip.addChild(mutationView.viewVector[changeIndex[k]]);
				mutationView.viewVector[changeIndex[k]] = redFilter;
			}
			originalView.reloadViewVector(false);
			mutationView.reloadViewVector(false);

			originalView.x = 0;
			originalView.y = i * (originalView.height + 125);
			var downArrow:DownArrow = new DownArrow();
			downArrow.x = this.scrollPane.width / 2 - 27;
			downArrow.y = originalView.y + originalView.height - 27;

			mutationView.x = 0;
			mutationView.y = downArrow.y + downArrow.height + 10;

			var splitLine:SplitLine = new SplitLine();
			splitLine.y = mutationView.y + mutationView.height + 10;

			this.scrollMovieClip.addChild(originalView);
			this.scrollMovieClip.addChild(mutationView);
			this.scrollMovieClip.addChild(downArrow);
			this.scrollMovieClip.addChild(splitLine);


			this.scrollPane.source = this.scrollMovieClip;
			this.scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
			this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
			this.view.expressionMovieClip.addChild(this.scrollPane);
			var loopIndex = int(this.scrollMovieClip.height / this.scrollPane.height) + 1;
			for (var j:int = 1; j < loopIndex; j++) {
				var updateLogic:Function = function updateScroll(e:View) {
					var t:Timer = new Timer(10, 1);
					t.addEventListener(TimerEvent.TIMER, function (ee:TimerEvent) {
						scrollPane.verticalScrollBar.scrollPosition = (e.sceneNextChange.indexOf(updateScroll) + 1) * scrollPane.height;
					})
					t.start();
				};
				this.view.sceneNextChange.push(updateLogic);
			}
		}


	}
}
}
