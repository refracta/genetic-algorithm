/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 12:40
 */
package com.wg.ga.missile.map {
import com.wg.ga.missile.*;

import flash.display.MovieClip;

public class MapObject {
	private var _missileMap:MissileMap;
	private var _expressionObject:MovieClip;

	public function get missileMap():MissileMap {
		return _missileMap;
	}

	public function set missileMap(value:MissileMap):void {
		_missileMap = value;
	}

	public function set expressionObject(value:MovieClip):void {
		_expressionObject = value;
	}

	public function get expressionObject():MovieClip {
		return _expressionObject;
	}

	public function MapObject(missileMap:MissileMap, initExpressionBoolean:Boolean = false) {
		this._missileMap = missileMap;
		if (initExpressionBoolean) {
			initExpression();
		}
	}

	public function initExpression() {
		this._expressionObject = new MovieClip();
		this._expressionObject.graphics.beginFill(0xff0000, 1.0);
		this._expressionObject.graphics.drawRect(0, 0, _missileMap.objectSize, _missileMap.objectSize);
	}




	public function getLocation():MapLocation {
		for (var x:int = 0; x < _missileMap.mapData.length; x++) {
			var indexOf:int = _missileMap.mapData[x].indexOf(this);
			if (indexOf != -1) {
				return new MapLocation(x, indexOf);
			}
		}
		return null;
	}
}
}
