/**
 * 개발자 : refracta
 * 날짜   : 2014-08-17 오전 10:50
 */
package com.wg.ga.expression.scene.missile {
import com.refracta.view.BlueFilterClip;
import com.refracta.view.FitnessObject;
import com.refracta.view.FitnessObjectOutline;
import com.refracta.view.PlayConsole;
import com.refracta.view.ScrollPaneWrapper;
import com.wg.ga.expression.ui.MissileUserInterfaceWrapper;
import com.wg.ga.framework.view.PresentationManager;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.framework.view.View;
import com.wg.ga.missile.MissileMapGraphicWrapper;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.missile.map.MissileMap;

import fl.containers.ScrollPane;
import fl.controls.ScrollPolicy;

import flash.events.MouseEvent;

public class FitnessScene extends Scene {
	private var _missileUserInterface:MissileUserInterfaceWrapper;
	private var _graphicWrapper:MissileMapGraphicWrapper;
	private var _entityGroup:Vector.<MissileTargetEntity>;
	private var _scrollPane:ScrollPane;
	private var _scrollMovieClip:ScrollPaneWrapper;
	private var _currentClickIndex:uint = 0;
	private var _presentationManager:PresentationManager;
//	private var
	private var _console:PlayConsole;

	public function get entityGroup():Vector.<MissileTargetEntity> {
		return _entityGroup;
	}

	public function get currentClickIndex():uint {
		return _currentClickIndex;
	}

	public function FitnessScene(missileUserInterface:MissileUserInterfaceWrapper,presentationManager:PresentationManager, entityGroup:Vector.<MissileTargetEntity>) {
		this._presentationManager = presentationManager;
		this._missileUserInterface = missileUserInterface;
		this._entityGroup = entityGroup;
	}

	public function get missileUserInterface():MissileUserInterfaceWrapper {
		return _missileUserInterface;
	}

	public function set missileUserInterface(value:MissileUserInterfaceWrapper):void {
		_missileUserInterface = value;
	}

	public function get graphicWrapper():MissileMapGraphicWrapper {
		return _graphicWrapper;
	}

	public function set graphicWrapper(value:MissileMapGraphicWrapper):void {
		_graphicWrapper = value;
	}

	private var _fitnessObjects:Vector.<FitnessObject>;

	public function get scrollPane():ScrollPane {
		return _scrollPane;
	}

	public function set scrollPane(value:ScrollPane):void {
		_scrollPane = value;
	}

	public function get scrollMovieClip():ScrollPaneWrapper {
		return _scrollMovieClip;
	}

	public function set scrollMovieClip(value:ScrollPaneWrapper):void {
		_scrollMovieClip = value;
	}

	public function get console():PlayConsole {
		return _console;
	}

	public function set console(value:PlayConsole):void {
		_console = value;
	}

	public function get fitnessObjects():Vector.<FitnessObject> {
		return _fitnessObjects;
	}

	public function set fitnessObjects(value:Vector.<FitnessObject>):void {
		_fitnessObjects = value;
	}

	override public function init():void {
		this._console = new PlayConsole();
		this._console.playGene.text = "none";
		this._console.generation.text = (_presentationManager.presentationViews.indexOf(this.view)-1)+"세대";
		this._console.x = 3;
		this._console.y = 573;
		this.view.expressionMovieClip.addChild(this._console);
		this._scrollPane = new ScrollPane();
		this._scrollPane.x = 2;
		this._scrollPane.y = 505;
		this._scrollPane.width = 499;
		this._scrollPane.height = 66;
		this._scrollMovieClip = new ScrollPaneWrapper();
		_fitnessObjects = new Vector.<FitnessObject>();
		for (var i:int = 0; i < _entityGroup.length; i++) {
			var fObject:FitnessObject = new FitnessObject();
			fObject.rank.text = (i + 1) + "위";
			fObject.rank.mouseEnabled = false;
			fObject.fitnessText.text = _entityGroup[i].getTotalGeneFitness() + "";
			fObject.fitnessText.mouseEnabled = false;
			fObject.x = i * fObject.width;
			_fitnessObjects.push(fObject);


			fObject.addEventListener(MouseEvent.CLICK, function (e:MouseEvent) {
				_fitnessObjects[_currentClickIndex].removeChild(_fitnessObjects[_currentClickIndex].outline);
				_fitnessObjects[_currentClickIndex].outline = new FitnessObjectOutline();
				_fitnessObjects[_currentClickIndex].addChildAt(_fitnessObjects[_currentClickIndex].outline, 0);

				var object:FitnessObject = e.currentTarget as FitnessObject;
				_currentClickIndex = _fitnessObjects.indexOf(object);

				var filterClip:BlueFilterClip = new BlueFilterClip();
				filterClip.viewClip.addChild(new FitnessObjectOutline());
				_fitnessObjects[_currentClickIndex].removeChild(_fitnessObjects[_currentClickIndex].outline);
				_fitnessObjects[_currentClickIndex].outline = filterClip;
				_fitnessObjects[_currentClickIndex].addChildAt(_fitnessObjects[_currentClickIndex].outline, 0);
			});
			this._scrollMovieClip.addChild(fObject);
		}


		_fitnessObjects[0].removeChild(_fitnessObjects[0].outline);
		var filter0:BlueFilterClip = new BlueFilterClip();
		filter0.viewClip.addChild(new FitnessObjectOutline());
		_fitnessObjects[0].outline = filter0;
		_fitnessObjects[0].addChildAt(_fitnessObjects[0].outline, 0);


		this._scrollPane.source = this._scrollMovieClip;
		this._scrollPane.verticalScrollPolicy = ScrollPolicy.OFF;
		this._scrollPane.horizontalScrollPolicy = ScrollPolicy.ON;
		this.view.expressionMovieClip.addChild(this._scrollPane);

		this._graphicWrapper = new MissileMapGraphicWrapper(this.missileUserInterface.viewMapData);
		this._missileUserInterface.missileMapData.mapData;
		this.view.expressionMovieClip.addChild(this._graphicWrapper.view);
		this._graphicWrapper.drawObject();

		this.view.viewIn = function (e:View) {
			view.defaultFadeIn();
			initScene(view);
		};
	}

}
}
