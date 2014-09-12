/**
 * 개발자 : refracta
 * 날짜   : 2014-08-17 오전 12:49
 */
package com.wg.ga.missile.map {
import com.wg.ga.missile.map.BlockageObject;

import flash.display.MovieClip;

public class BlockageObject extends MapObject {
	private var _strength:uint = 3;
	private var initialStrength:uint = 3;

	public function get strength():uint {
		return _strength;
	}

	public function setDefaultStrength(strength:uint) {
		this._strength = strength;
		this._strength = initialStrength;
	}

	public function set strength(value:uint):void {
		_strength = value;

	}

	public function BlockageObject(missileMap:com.wg.ga.missile.map.MissileMap, strength:uint, initExpressionBoolean:Boolean = false) {
		super(missileMap, initExpressionBoolean);
		this.setDefaultStrength(strength);
	}


	override public function initExpression() {
		this.expressionObject = new MovieClip();
		this.expressionObject.graphics.beginFill(0x000000, strength / initialStrength * 1.0);
		this.expressionObject.graphics.drawRect(0, 0, missileMap.objectSize, missileMap.objectSize);

	}

	public function copyBlock(map:MissileMap):BlockageObject {
		var copy:BlockageObject = new BlockageObject(map, this.initialStrength,true);
		copy.strength = this._strength;
		return copy;
	}
}
}
