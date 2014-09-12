/**
 * 개발자 : refracta
 * 날짜   : 2014-08-12 오전 5:08
 */
package com.wg.ga.expression.scene.functionmax {
import com.refracta.view.BinaryGeneInformationView;
import com.refracta.view.BlueFilterClip;
import com.refracta.view.DefaultSizeLabel;
import com.refracta.view.DownArrow;
import com.refracta.view.GreenFilterClip;
import com.refracta.view.RedFilterClip;
import com.refracta.view.ScrollPaneWrapper;
import com.refracta.view.SplitLine;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.view.Scene;

import fl.containers.ScrollPane;
import fl.controls.ScrollPolicy;

import flash.geom.ColorTransform;

public class CrossoverScene extends Scene {
	private var reproductionData:Vector.<Vector.<BinaryEntity>>;
	private var scrollPane:ScrollPane;
	private var scrollMovieClip:ScrollPaneWrapper;

	public function getHalfIndex(geneLength:Number) {
		var halfIndex:int = (geneLength - 1) / 2 + 1;
		return halfIndex;
	}

	public function CrossoverScene(reproductionData:Vector.<Vector.<BinaryEntity>>) {
		this.reproductionData = reproductionData;
	}


	override public function init():void {
		this.scrollPane = new ScrollPane();
		this.scrollPane.x = 28;
		this.scrollPane.y = 83;
		this.scrollPane.width = 444;
		this.scrollPane.height = 405;
		this.scrollMovieClip = new ScrollPaneWrapper();

		var selectionLogicLabel:DefaultSizeLabel = new DefaultSizeLabel();
		selectionLogicLabel.setText("(재생산 과정) 교차(교배) 로직");
		selectionLogicLabel.y = 28;
		this.view.expressionMovieClip.addChild(selectionLogicLabel);

		for (var i:int = 0; i < reproductionData.length; i++) {
			var source1:BinaryEntity = reproductionData[i][0];
			var source2:BinaryEntity = reproductionData[i][1];
			var reproduction:BinaryEntity = reproductionData[i][2];
			var binaryEntityView1:BinaryGeneInformationView = new BinaryGeneInformationView(source1, false);
			var binaryEntityView2:BinaryGeneInformationView = new BinaryGeneInformationView(source2, false);
			var reproductionEntityView:BinaryGeneInformationView = new BinaryGeneInformationView(reproduction, false);

			var halfIndex:uint = this.getHalfIndex(source1.getGeneInformation().length);
			for (var j:int = 0; j < halfIndex; j++) {
				var redFilterClip:RedFilterClip = new RedFilterClip();
				redFilterClip.viewClip.addChild(binaryEntityView1.viewVector[j]);
				binaryEntityView1.viewVector[j] = redFilterClip;
				var redFilterClip:RedFilterClip = new RedFilterClip();
				redFilterClip.viewClip.addChild(binaryEntityView1.viewVector[j]);
				binaryEntityView1.viewVector[j] = redFilterClip;
			}
			binaryEntityView1.reloadViewVector(false);

			for (var j:int = halfIndex; j < source2.getGeneInformation().length; j++) {
				var blueFilterClip:BlueFilterClip = new BlueFilterClip();
				blueFilterClip.viewClip.addChild(binaryEntityView2.viewVector[j]);
				binaryEntityView2.viewVector[j] = blueFilterClip;
				var blueFilterClip:BlueFilterClip = new BlueFilterClip();
				blueFilterClip.viewClip.addChild(binaryEntityView2.viewVector[j]);
				binaryEntityView2.viewVector[j] = blueFilterClip;
			}
			binaryEntityView2.reloadViewVector(false);



			for (var j:int = 0; j < halfIndex; j++) {
				var redSubFilter:RedFilterClip = new RedFilterClip();
				redSubFilter.viewClip.addChild(reproductionEntityView.viewVector[j]);
				reproductionEntityView.viewVector[j] = redSubFilter;
				var redSubFilter:RedFilterClip = new RedFilterClip();
				redSubFilter.viewClip.addChild(reproductionEntityView.viewVector[j]);
				reproductionEntityView.viewVector[j] = redSubFilter;
			}
			for (var j:int = halfIndex; j < reproduction.getGeneInformation().length; j++) {
				var blueSubFilter:BlueFilterClip= new BlueFilterClip();
				blueSubFilter.viewClip.addChild(reproductionEntityView.viewVector[j]);
				reproductionEntityView.viewVector[j] = blueSubFilter;
				var blueSubFilter:BlueFilterClip= new BlueFilterClip();
				blueSubFilter.viewClip.addChild(reproductionEntityView.viewVector[j]);
				reproductionEntityView.viewVector[j] = blueSubFilter;
			}
			reproductionEntityView.reloadViewVector(false);

			binaryEntityView1.x = 0;
			binaryEntityView1.y = i * (binaryEntityView1.height + 200);
			binaryEntityView2.x = 0;
			binaryEntityView2.y = binaryEntityView1.y + binaryEntityView1.height;
			var downArrow:DownArrow = new DownArrow();
			downArrow.x = this.scrollPane.width / 2 - 27;
			downArrow.y = binaryEntityView1.y + binaryEntityView1.height * 2 - 27;
			reproductionEntityView.y = downArrow.y + downArrow.height + 10;
			var splitLine:SplitLine = new SplitLine();
			splitLine.y = reproductionEntityView.y + reproductionEntityView.height + 10;

			binaryEntityView1.setSplitLine(halfIndex);
			binaryEntityView2.setSplitLine(halfIndex);
			reproductionEntityView.setSplitLine(halfIndex);
			this.scrollMovieClip.addChild(binaryEntityView1);
			this.scrollMovieClip.addChild(binaryEntityView2);
			this.scrollMovieClip.addChild(downArrow);
			this.scrollMovieClip.addChild(reproductionEntityView);
			this.scrollMovieClip.addChild(splitLine);

		}
		this.scrollPane.source = this.scrollMovieClip;
		this.scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
		this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
		this.view.expressionMovieClip.addChild(this.scrollPane);
	}
}
}
