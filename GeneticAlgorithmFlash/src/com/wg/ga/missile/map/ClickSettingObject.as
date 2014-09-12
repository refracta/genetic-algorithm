/**
 * 개발자 : refracta
 * 날짜   : 2014-08-17 오전 12:14
 */
package com.wg.ga.missile.map {
import com.refracta.view.MissileUserInterface;
import com.wg.ga.expression.ui.MissileUserInterfaceWrapper;
import com.wg.ga.missile.MissileMapGraphicWrapper;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class ClickSettingObject extends MapObject {
	private var missileUserInterface:MissileUserInterfaceWrapper;
	private var missileMapGraphicWrapper:MissileMapGraphicWrapper;

	public function ClickSettingObject(missileUserInterface:MissileUserInterfaceWrapper, missileMapGraphicWrapper:MissileMapGraphicWrapper, initExpressionBoolean:Boolean = false) {
		this.missileMapGraphicWrapper = missileMapGraphicWrapper;
		this.missileUserInterface = missileUserInterface;
		super(this.missileUserInterface.missileMapData, initExpressionBoolean);
		var clickSetting:Function = function (e:MouseEvent) {
			switch (missileUserInterface.getSettingObject()) {
				case "PLAYER":
					for (var x:int = 0; x < missileMap.mapData.length; x++) {
						for (var y:int = 0; y < missileMap.mapData[x].length; y++) {
							var currentObject:MapObject = missileMap.mapData[x][y];
							if (currentObject as MovableObject && !(currentObject as MissileObject)) {
								var clickSettingObject:ClickSettingObject = new ClickSettingObject(missileUserInterface, missileMapGraphicWrapper, true);
								missileMap.setObject(x, y, clickSettingObject);
							}
						}
					}
					missileMap.setObjectByMapLocation(getLocation(), new MovableObject(missileMap, missileUserInterface.playBlockage.selected, true));

					break;
				case "MISSILE":
					var targetObject:MovableObject = null;
					for (var x:int = 0; x < missileMap.mapData.length; x++) {
						for (var y:int = 0; y < missileMap.mapData[x].length; y++) {
							var currentObject:MapObject = missileMap.mapData[x][y];
							if (currentObject as MovableObject) {
								if (currentObject as MissileObject) {
									var clickSettingObject:ClickSettingObject = new ClickSettingObject(missileUserInterface, missileMapGraphicWrapper, true);
									missileMap.setObject(x, y, clickSettingObject);
								} else {
									targetObject = MovableObject(currentObject);
								}
							}
						}
					}
					if (targetObject != null) {
						missileMap.setObjectByMapLocation(getLocation(), new MissileObject(missileMap, targetObject, missileUserInterface.missileBlockage.selected, true));
					}

					break;
				case "BLOCKAGE":
					missileMap.setObjectByMapLocation(getLocation(), new BlockageObject(missileMap, missileUserInterface.blockageStrength.value,true));
					break;

			}
			missileMapGraphicWrapper.drawObject();

		};

		this.expressionObject.addEventListener(MouseEvent.CLICK, clickSetting);


	}

	override public function initExpression() {
		this.expressionObject = new MovieClip();
		this.expressionObject.graphics.beginFill(0xffffff, 0.5);
		this.expressionObject.graphics.drawRect(0, 0, missileMap.objectSize, missileMap.objectSize);
	}
}
}
