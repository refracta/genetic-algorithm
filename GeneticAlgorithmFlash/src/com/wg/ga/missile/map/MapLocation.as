/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 4:31
 */
package com.wg.ga.missile.map {
public class MapLocation {

	private var _x:int = 0;
	private var _y:int = 0;

	public static function getDistance(l1:MapLocation, l2:MapLocation) {
		var xAbs:Number = Math.abs(l1.x - l2.x);
		var yAbs:Number = Math.abs(l1.y - l2.y);
		return Math.pow(xAbs * xAbs + yAbs * yAbs, 0.5);
	}

	public function MapLocation(x:int, y:int) {
		this._x = x;
		this._y = y;
	}

	public function get x():int {
		return _x;
	}

	public function set x(value:int):void {
		_x = value;
	}

	public function get y():int {
		return _y;
	}

	public function set y(value:int):void {
		_y = value;
	}

	public function toString():String {
		return "MapLocation{x=" + String(_x) + ",y=" + String(_y) + "}";
	}

	public function equals(object:MapLocation):Boolean {
		return this._x == object.x && this._y == object.y;
	}

}
}
