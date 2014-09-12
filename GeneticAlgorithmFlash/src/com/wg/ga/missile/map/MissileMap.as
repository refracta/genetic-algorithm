/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 12:40
 */
package com.wg.ga.missile.map {
import com.wg.ga.framework.util.CloneUtil;

public class MissileMap {
	private var _mapData:Vector.<Vector.<MapObject>>;
	private var _objectSize:Number = 10;

	public function MissileMap(width:int, height:int, initMapData:Boolean = true) {
		if (initMapData) {
			this._mapData = new Vector.<Vector.<MapObject>>();
			for (var i:int = 0; i < width; i++) {
				this.mapData[i] = new Vector.<MapObject>();
				for (var j:int = 0; j < height; j++) {
					this.mapData[i][j] = null;
				}
			}
		}

	}

	public function getMapObject(x:int, y:int):MapObject {
		return this.mapData[x][y];
	}

	public function getMapObjectByMapLocation(mapLocation:MapLocation):MapObject {
		return getMapObject(mapLocation.x, mapLocation.y);
	}

	public function setObject(x:int, y:int, object:MapObject):Boolean {
		if (isExistsLocation) {
			this._mapData[x][y] = object;
			return true;
		}

		return false;
	}

	public function setObjectByMapLocation(mapLocation:MapLocation, object:MapObject):Boolean {
		return setObject(mapLocation.x, mapLocation.y, object);
	}

	public function get objectSize():Number {
		return _objectSize;
	}

	public function set objectSize(value:Number):void {
		_objectSize = value;
	}

	public function get mapWidth():int {
		return this.mapData.length;
	}

	public function get mapHeight():int {
		return this.mapData[0].length;
	}

	public function get mapData():Vector.<Vector.<MapObject>> {
		return _mapData;
	}

	public function set mapData(value:Vector.<Vector.<MapObject>>):void {
		_mapData = value;
	}

	public function isExistsLocation(x:int, y:int):Boolean {
		if (-1 < x && x < this._mapData.length) {
			if (-1 < y && y < this._mapData[0].length) {
				return true;
			}
		}
		return false;
	}

	public function isExistsLocationByMap(mapLocation:MapLocation):Boolean {
		return isExistsLocation(mapLocation.x, mapLocation.y);
	}

	public function copyMap():MissileMap {
		var emptyVector:Vector.<Vector.<MapObject>> = new Vector.<Vector.<MapObject>>();
		var returnMissileMap:MissileMap = new MissileMap(-1, -1, false);
		returnMissileMap.objectSize = this.objectSize;
		for (var i:int = 0; i < this._mapData.length; i++) {
			var currentVector:Vector.<MapObject> = this._mapData[i];
			emptyVector.push(new Vector.<MapObject>());
			for (var j:int = 0; j < currentVector.length; j++) {
				var mapObject:MapObject = currentVector[j];
				emptyVector[i][j] = mapObject;
				var block:BlockageObject = mapObject as BlockageObject;
				if (block) {
					emptyVector[i][j] = block.copyBlock(returnMissileMap);
				} else {
					emptyVector[i][j] = mapObject;
				}
			}
		}
		returnMissileMap.mapData = emptyVector;

		return returnMissileMap;
	}

}
}
