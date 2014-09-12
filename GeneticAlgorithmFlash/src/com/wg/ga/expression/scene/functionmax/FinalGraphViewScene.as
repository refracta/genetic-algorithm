/**
 * 개발자 : refracta
 * 날짜   : 2014-08-11 오전 7:03
 */
package com.wg.ga.expression.scene.functionmax {
import com.refracta.view.BestEntityLabel;

import bkde.as3.boards.GraphingBoardWrapper;
import bkde.as3.parsers.MathParser;

import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.expression.ui.MainUserInterfaceWrapper;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;

public class FinalGraphViewScene extends Scene {
	private var mainUserInterface:MainUserInterfaceWrapper;
	private var entityGroup:Vector.<BinaryEntity>;
	private var graphingBoard:GraphingBoardWrapper;


	public function FinalGraphViewScene(mainUserInterface:MainUserInterfaceWrapper, entityGroup:Vector.<BinaryEntity>) {
		this.mainUserInterface = mainUserInterface;
		this.entityGroup = entityGroup;
	}

	public static function getBestEntity(binaryEntities:Vector.<BinaryEntity>):BinaryEntity {
		binaryEntities.sort(new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER).compare)
		return binaryEntities[0];
	}

	override public function init():void {
		this.graphingBoard = this.mainUserInterface.createGraphingBoard();
		this.mainUserInterface.drawSettingGraph(this.graphingBoard);
		this.view.expressionMovieClip.addChild(graphingBoard);
		var bestEntity:BestEntityLabel = new BestEntityLabel();
		var index:int = this.entityGroup.indexOf(getBestEntity(entityGroup));
		bestEntity.setText("최고 개체 : "+index+"세대, " + getBestEntity(entityGroup).toString() + " ");
		bestEntity.x = 0;
		bestEntity.y = 500 - bestEntity.height;
		this.view.expressionMovieClip.addChild(bestEntity);
		graphRemoveInit();
		drawEntityGroupsGraph();
		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};

	}


	public function drawEntityGroupsGraph():void {
		var stepColor:Number = 255 * 2 / this.entityGroup.length;
		for (var i:int = 0; i < this.entityGroup.length; i++) {
			var graphArray:Array = new Array();
			var binaryEntity:BinaryEntity = this.entityGroup[i];
			var drawStep:Number = Math.abs(this.graphingBoard.nYmax - this.graphingBoard.nYmin) / 15;
			GraphingBoardWrapper.addCoordinatesToGraphArray(graphArray, binaryEntity.getDexNumber(), binaryEntity.getTotalGeneFitness() - drawStep);
			GraphingBoardWrapper.addCoordinatesToGraphArray(graphArray, binaryEntity.getDexNumber(), binaryEntity.getTotalGeneFitness() + drawStep);
			var footerHex:String = (int(stepColor * i * 0.5)).toString(16);
			if (int(stepColor * i * 0.5) > 255) {
				footerHex = "ff";
			}
			if (footerHex.length == 1) {
				footerHex = "0" + footerHex;
			}
			var currentColor:uint = parseInt("0x0000" + footerHex);
			this.graphingBoard.drawGraph((i + 2), this.mainUserInterface.defaultGraphThink + 10 / 3, graphArray, currentColor)
		}
	}


	public function graphRemoveInit():void {

		for (var i:int = 2; i < entityGroup.length + 1; i++) {
			this.graphingBoard.removeGraph(i);
		}
	}
}
}
