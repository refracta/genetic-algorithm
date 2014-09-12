/**
 * 개발자 : refracta
 * 날짜   : 2014-08-11 오후 11:42
 */
package com.wg.ga.expression.scene.functionmax {
import com.bit101.charts.PieChart;
import com.refracta.view.BinaryGeneInformationView;
import com.refracta.view.DefaultSizeLabel;
import com.refracta.view.ScrollPaneWrapper;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.logic.impl.BinaryHighScoreRouletteWheelSelectionLogic;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;

import fl.containers.ScrollPane;
import fl.controls.ScrollPolicy;

import flash.events.TimerEvent;
import flash.utils.Timer;

public class SelectionLogicScene extends Scene {
	private var selectionEntities:Vector.<BinaryEntity>;
	private var pieChart:PieChart;
	private var selectionLogic:BinaryHighScoreRouletteWheelSelectionLogic;
	private var scrollPane:ScrollPane;
	private var scrollMovieClip:ScrollPaneWrapper;
	private var prevEntities:Vector.<BinaryEntity>;

	public function SelectionLogicScene(selectionLogic:BinaryHighScoreRouletteWheelSelectionLogic, prevEntities:Vector.<BinaryEntity>, selectionEntities:Vector.<BinaryEntity>) {
		this.selectionLogic = selectionLogic;
		this.prevEntities = prevEntities;
		this.selectionEntities = selectionEntities;
	}

	override public function init():void {
		this.scrollPane = new ScrollPane();
		this.scrollPane.x = 28;
		this.scrollPane.y = 83;
		this.scrollPane.width = 444;
		this.scrollPane.height = 405;
		this.scrollMovieClip = new ScrollPaneWrapper();


		var selectionLogicLabel:DefaultSizeLabel = new DefaultSizeLabel();
		selectionLogicLabel.setText("선택 로직, 집단의 " + this.selectionLogic.percent + "% 선택");
		selectionLogicLabel.y = 28;
		this.view.expressionMovieClip.addChild(selectionLogicLabel);

		this.pieChart = selectionLogic.getPieChart(this.prevEntities);
		this.pieChart.setSize(this.scrollPane.width - 20, 200);
		this.scrollMovieClip.addChild(this.pieChart);

		var noticeSelection:DefaultSizeLabel = new DefaultSizeLabel();
		noticeSelection.setLabelWidth(this.scrollPane.width);
		noticeSelection.y = this.pieChart.height + 10;
		noticeSelection.setText(selectionEntities.length + "개의 개체가 선택되었음.")
		this.scrollMovieClip.addChild(noticeSelection);

		var margin:Number = noticeSelection.y + noticeSelection.height;
		for (var i:int = 0; i < this.selectionEntities.length; i++) {
			var currentInformationView:BinaryGeneInformationView = new BinaryGeneInformationView(this.selectionEntities[i], true);
			currentInformationView.y = margin + (i * (currentInformationView.height + 5));
			currentInformationView.x = 0;
			this.scrollMovieClip.addChild(currentInformationView);
		}

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
