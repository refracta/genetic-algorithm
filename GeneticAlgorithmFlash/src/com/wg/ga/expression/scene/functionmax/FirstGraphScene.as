/**
 * 개발자 : refracta
 * 날짜   : 14. 8. 8 오후 6:18
 */
package com.wg.ga.expression.scene.functionmax {

import bkde.as3.boards.GraphingBoardWrapper;

import com.wg.ga.expression.ui.MainUserInterfaceWrapper;

import com.wg.ga.framework.view.Scene;


public class FirstGraphScene extends Scene {
	private var _graphingBoard:GraphingBoardWrapper;
	private var mainUserInterface:MainUserInterfaceWrapper;


	public function get graphingBoard():GraphingBoardWrapper {
		return _graphingBoard;
	}

	public function FirstGraphScene(mainUserInterface:MainUserInterfaceWrapper) {
		this.mainUserInterface = mainUserInterface;
	}

	override public function init():void {
		this._graphingBoard = this.mainUserInterface.createGraphingBoard();
		this.mainUserInterface.drawSettingGraph(this.graphingBoard);
		this.view.expressionMovieClip.addChild(this._graphingBoard);
	}

}
}
