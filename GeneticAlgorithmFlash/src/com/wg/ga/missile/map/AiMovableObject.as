/**
 * 개발자 : refracta
 * 날짜   : 2014-08-24 오후 8:00
 */
package com.wg.ga.missile.map {
public class AiMovableObject extends MovableObject {

	public function AiMovableObject(missileMap:MissileMap, canBreak:Boolean, initExpressionBoolean:Boolean) {
		super(missileMap, canBreak, initExpressionBoolean);
	}

	public function avoidTarget(targetObject:MovableObject):Boolean {
		var myLocation:MapLocation = getLocation();
		var targetLocation:MapLocation = targetObject.getLocation();
		if (targetLocation == null || myLocation == null) {
			return false;
		}

		if (targetLocation.x == myLocation.x) {
			if (!(targetLocation.y == myLocation.y)) {
				if (targetLocation.y > myLocation.y) {
					moveDown();
				} else {
					moveUp();
				}
			}
		} else {
			if (targetLocation.x > myLocation.x) {
				moveLeft();
			} else {
				moveRight();
			}
		}
		return true;

	}

}
}
