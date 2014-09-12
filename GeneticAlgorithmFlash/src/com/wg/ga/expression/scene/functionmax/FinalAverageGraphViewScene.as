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

public class FinalAverageGraphViewScene extends Scene {
	private var mainUserInterface:MainUserInterfaceWrapper;
	private var entityGroup:Vector.<Number>;
	private var graphingBoard:GraphingBoardWrapper;


	public function FinalAverageGraphViewScene(mainUserInterface:MainUserInterfaceWrapper, entityGroup:Vector.<Number>) {
		this.mainUserInterface = mainUserInterface;
		this.entityGroup = entityGroup;
	}

	override public function init():void {
		this.graphingBoard = this.mainUserInterface.createGraphingBoard();
		this.mainUserInterface.drawSettingGraph(this.graphingBoard);
		this.view.expressionMovieClip.addChild(graphingBoard);

		drawEntityGroupsGraph();
		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};

	}


	public function drawEntityGroupsGraph():void {
		var stepX = this.graphingBoard.nXmax/this.entityGroup.length
		var graphArray:Array = new Array();
		for (var i:int = 0; i < this.entityGroup.length; i++) {
			var currentX:Number = stepX*i +stepX/2;
			var currentValue:Number = this.entityGroup[i];
			GraphingBoardWrapper.addCoordinatesToGraphArray(graphArray, currentX, currentValue);
		}
		this.graphingBoard.drawGraph(1, this.mainUserInterface.defaultGraphThink, graphArray, 0x0000AA)
	}


	public function graphRemoveInit():void {

		for (var i:int = 2; i < entityGroup.length + 1; i++) {
			this.graphingBoard.removeGraph(i);
		}
	}
}
}
