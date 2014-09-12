/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 2:48
 */
package com.wg.ga.missile {
import com.wg.ga.missile.map.MissileMap;

import flash.display.MovieClip;

import flash.display.MovieClip;

public class MissileMapGraphicWrapper {
	private var _missileMap:MissileMap;
	private var _view:MovieClip;
	private var _expressionClip:MovieClip;
	private var _objectClip:MovieClip;
	private var _thickSize:int = 1;
	private var _thickColor:Number = 0x000000;


	public function set objectClip(value:MovieClip):void {
		_objectClip = value;
	}

	public function get objectClip():MovieClip {
		return _objectClip;
	}

	public function get thickColor():Number {
		return _thickColor;
	}

	public function set thickColor(value:Number):void {
		_thickColor = value;
	}

	public function MissileMapGraphicWrapper(missileMap:MissileMap) {
		this._missileMap = missileMap;
		this._view = new MovieClip();
	}

	public function get missileMap():MissileMap {
		return _missileMap;
	}

	public function set missileMap(value:MissileMap):void {
		_missileMap = value;
	}

	public function get view():MovieClip {
		return _view;
	}

	public function set view(value:MovieClip):void {
		_view = value;
	}

	public function get expressionClip():MovieClip {
		return _expressionClip;
	}

	public function set expressionClip(value:MovieClip):void {
		_expressionClip = value;
	}

	public function get thickSize():int {
		return _thickSize;
	}

	public function set thickSize(value:int):void {
		_thickSize = value;
	}

	public function addExpressionClip() {
		this._view.addChild(this._expressionClip);
	}

	public function addObjectClip() {
		if (this._expressionClip == null) {
			drawGrid();
		}
		this._expressionClip.addChild(this._objectClip);

	}

	public function removeObjectClip():Boolean {
		if (this._expressionClip == null) {
			drawGrid();
		}
		if (this._objectClip != null) {
			if (this._expressionClip.contains(this._objectClip)) {
				this._expressionClip.removeChild(this._objectClip);
				return true;
			}
		}

		return false;
	}

	public function removeExpressionClip():Boolean {
		if (_expressionClip != null) {
			if (this._view.contains(_expressionClip)) {
				this._view.removeChild(this._expressionClip);
				return true;
			}
		}
		return false;
	}

	public function drawObject() {
		this.removeObjectClip();
		this._objectClip = new MovieClip();
		this.addObjectClip();
		for (var x:int = 0; x < _missileMap.mapData.length; x++) {
			for (var y:int = 0; y < _missileMap.mapData[x].length; y++) {
				if (_missileMap.mapData[x][y] != null) {
					var wrapper:MovieClip = new MovieClip();
					wrapper.addChild(_missileMap.mapData[x][y].expressionObject);
					wrapper.x = x * this._missileMap.objectSize + (x + 1);
					wrapper.y = y * this._missileMap.objectSize + (y+1);
					this._objectClip.addChild(wrapper);
				}
			}
		}
	}

	public function drawGrid() {
		this.removeExpressionClip();
		this._expressionClip = new MovieClip();
		this.addExpressionClip();
		// trace("그려짐");
		var thickWidth = (this._missileMap.mapWidth + 1) * thickSize;
		var objectSpaceWidth = this._missileMap.mapWidth * this._missileMap.objectSize;
		var thickHeight = (this._missileMap.mapHeight + 1) * thickSize;
		var objectSpaceHeight = this._missileMap.mapHeight * this._missileMap.objectSize;
		//내부 479
		this._expressionClip.graphics.lineStyle(thickSize, thickSize, 1);
		this._expressionClip.graphics.moveTo(0, 0);
		this._expressionClip.graphics.lineTo(thickWidth + objectSpaceWidth - this.thickSize, 0);
		this._expressionClip.graphics.lineTo(thickWidth + objectSpaceWidth - this.thickSize, thickHeight + objectSpaceHeight - this.thickSize);
		this._expressionClip.graphics.lineTo(0, thickHeight + objectSpaceHeight - this.thickSize);
		this._expressionClip.graphics.lineTo(0, 0);
		var stepSize:int = this._missileMap.objectSize + this.thickSize;

		for (var y:int = stepSize; y < objectSpaceHeight + thickHeight; y += stepSize) {
			this._expressionClip.graphics.moveTo(0, y);
			this._expressionClip.graphics.lineTo(thickWidth + objectSpaceWidth, y);
		}
		for (var x:int = stepSize; x < objectSpaceWidth + thickWidth; x += stepSize) {
			this._expressionClip.graphics.moveTo(x, 0);
			this._expressionClip.graphics.lineTo(x, objectSpaceHeight + thickHeight);
		}

		/*		for (var y:int = this._missileMap.objectSize; y < objectSpaceHeight; y += this._missileMap.objectSize + this.thickSize) {
		 this._expressionClip.graphics.moveTo(0, y);
		 if (y + this._missileMap.objectSize + this.thickSize < objectSpaceHeight) {

		 this._expressionClip.graphics.lineTo(thickWidth + objectSpaceWidth - 1, y);
		 } else {

		 this._expressionClip.graphics.lineTo(thickWidth + objectSpaceWidth, y);
		 }
		 }*/
		/*
		 for (var y:int = this._missileMap.objectSize + thickSize; y < objectSpaceHeight; y += this._missileMap.objectSize ) {
		 this._expressionClip.graphics.moveTo(0, y);
		 this._expressionClip.graphics.lineTo(thickWidth + objectSpaceWidth, y);
		 }*/
	}


}
}
