/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 6:41
 */
package com.wg.ga.missile.map {
import com.wg.ga.missile.map.MapLocation;
import com.wg.ga.missile.map.MapLocation;

public class MovableObject extends MapObject {
	public var canBreak:Boolean = true;

	public function MovableObject(missileMap:MissileMap, canBreak:Boolean, initExpressionBoolean:Boolean = true) {
		super(missileMap, initExpressionBoolean);
		this.canBreak = canBreak;
	}

	private function moveObject(currentLocation:MapLocation, moveLocation:MapLocation):Boolean {
		var blockageObject:BlockageObject = missileMap.getMapObjectByMapLocation(moveLocation) as BlockageObject;
		if (blockageObject) {
			if (canBreak) {
				if (blockageObject.strength != 0) {
					blockageObject.strength = blockageObject.strength - 1;
					blockageObject.initExpression();
					return false;
				}
			} else {
				return false;
			}
		}
		if (missileMap.getMapObjectByMapLocation(moveLocation) as MissileObject) {
			removeObject(currentLocation);
			return false;
		}

		removeObject(currentLocation);
		return missileMap.setObject(moveLocation.x, moveLocation.y, this);
	}

	public function move(moveLocation:MapLocation):Boolean {
		var currentLocation:MapLocation = getLocation();
		if (currentLocation == null) {
			return false;
		}
		removeObject(currentLocation);
		return missileMap.setObject(moveLocation.x, moveLocation.y, this);
	}

	public function removeObject(mapLocation:MapLocation) {
		missileMap.mapData[mapLocation.x][mapLocation.y] = null;
	}

	public function moveDown():Boolean {
		var currentLocation:MapLocation = getLocation();
		if (currentLocation == null) {
			return false;
		}
		var moveLocation:MapLocation = new MapLocation(currentLocation.x, currentLocation.y - 1);
		if (!this.missileMap.isExistsLocationByMap(moveLocation)) {
			return false;
		}
		return moveObject(currentLocation, moveLocation);
	}

	public function moveUp():Boolean {
		var currentLocation:MapLocation = getLocation();
		if (currentLocation == null) {
			return false;
		}
		var moveLocation:MapLocation = new MapLocation(currentLocation.x, currentLocation.y + 1);
		if (!this.missileMap.isExistsLocationByMap(moveLocation)) {
			return false;
		}

		return moveObject(currentLocation, moveLocation);
	}

	public function moveRight():Boolean {
		var currentLocation:MapLocation = getLocation();
		if (currentLocation == null) {
			return false;
		}
		var moveLocation:MapLocation = new MapLocation(currentLocation.x + 1, currentLocation.y);
		if (!this.missileMap.isExistsLocationByMap(moveLocation)) {
			return false;
		}
		return moveObject(currentLocation, moveLocation);
	}

	public function moveLeft():Boolean {
		var currentLocation:MapLocation = getLocation();
		if (currentLocation == null) {
			return false;
		}
		var moveLocation:MapLocation = new MapLocation(currentLocation.x - 1, currentLocation.y);
		if (!this.missileMap.isExistsLocationByMap(moveLocation)) {
			return false;
		}
		return moveObject(currentLocation, moveLocation);
	}


}
}
