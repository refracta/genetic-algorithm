/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 8:29
 */
package com.wg.ga.missile.map {
import flash.display.MovieClip;

public class MissileObject extends MovableObject {
	private var _targetObject:MapObject;

	public function get targetObject():MapObject {
		return _targetObject;
	}

	public function set targetObject(value:MapObject):void {
		_targetObject = value;
	}

	public function MissileObject(missileMap:MissileMap, targetObject:MapObject, canBreak:Boolean, initExpressionBoolean:Boolean = true) {
		super(missileMap, canBreak, initExpressionBoolean);
		this._targetObject = targetObject;
		this.canBreak = true;
	}

	public override function initExpression() {
		this.expressionObject = new MovieClip();
		this.expressionObject.graphics.beginFill(0xff00ff, 1.0);
		this.expressionObject.graphics.drawRect(0, 0, missileMap.objectSize, missileMap.objectSize);
	}


	public function trackingTarget():Boolean {
		var myLocation:MapLocation = getLocation();
		var targetLocation:MapLocation = _targetObject.getLocation();
		if (targetLocation == null || myLocation == null) {
			return false;
		}
		//만약 목표물의 x 좌표가 미사일의 x 좌표와 같을 때
		if (targetLocation.x == myLocation.x) {
			if (targetLocation.y != myLocation.y) {
				if (targetLocation.y > myLocation.y) {
					moveUp();
				} else {
					moveDown();
				}
			}
		} else {
			if (targetLocation.x > myLocation.x) {
				moveRight();
			} else {
				moveLeft();
			}
		}
		return true;
	}
}
}
