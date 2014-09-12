/**
 * 개발자 : refracta
 * 날짜   : 2014-08-16 오전 10:54
 */
package com.wg.ga.expression.scene.missile {
import com.wg.ga.expression.ui.MissileUserInterfaceWrapper;
import com.wg.ga.framework.view.Scene;
import com.wg.ga.missile.MissileMapGraphicWrapper;
import com.wg.ga.missile.map.ClickSettingObject;
import com.wg.ga.missile.map.MapObject;
import com.wg.ga.missile.map.MovableObject;

import flash.events.MouseEvent;

public class FirstSettingScene extends Scene {
	private var _missileUserInterface:MissileUserInterfaceWrapper;
	private var _graphicWrapper:MissileMapGraphicWrapper;

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

	public function FirstSettingScene(missileUserInterface:MissileUserInterfaceWrapper) {
		this._missileUserInterface = missileUserInterface;
	}

	override public function init():void {
		this._graphicWrapper = new MissileMapGraphicWrapper(this._missileUserInterface.missileMapData);
		this._missileUserInterface.missileMapData.mapData
		this.view.expressionMovieClip.addChild(this._graphicWrapper.view);

		var cacheVector:Vector.<Vector.<MapObject>> = this._missileUserInterface.missileMapData.mapData;
		for (var x:int = 0; x < cacheVector.length; x++) {
			for (var y:int = 0; y < cacheVector[x].length; y++) {
				var clickSettingObject:ClickSettingObject = new ClickSettingObject(this.missileUserInterface,this.graphicWrapper, true);
				this.missileUserInterface.missileMapData.setObject(x, y, clickSettingObject);

			}
		}
		this._graphicWrapper.drawObject();
	}
}
}
