/**
 * 개발자 : refracta
 * 날짜   : 2014-08-16 오전 10:56
 */
package com.wg.ga.starter.missile {
import com.refracta.view.ArrowSymbol;
import com.refracta.view.DefaultSizeLabel;
import com.refracta.view.DynamicButton;
import com.wg.ga.expression.scene.missile.FirstSettingScene;
import com.wg.ga.expression.scene.missile.FitnessScene;
import com.wg.ga.expression.ui.MissileUserInterfaceWrapper;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.framework.view.PresentationManager;
import com.wg.ga.framework.view.View;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.missile.map.AiMovableObject;
import com.wg.ga.missile.map.BlockageObject;
import com.wg.ga.missile.map.ClickSettingObject;
import com.wg.ga.missile.map.MissileMap;
import com.wg.ga.missile.map.MissileObject;
import com.wg.ga.missile.map.MovableObject;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

[SWF(backgroundColor="0xffffff", width="501", height="840")]
public class MissileAI_GA extends MovieClip {
	private var missileUserInterface:MissileUserInterfaceWrapper;
	private var presentationManager:PresentationManager;
	var firstScene:FirstSettingScene;


	public function lockUI() {
		this.missileUserInterface.settingObject.enabled = false;
		this.missileUserInterface.numOfGene.enabled = false;
		this.missileUserInterface.missileBlockage.enabled = false;
		this.missileUserInterface.playBlockage.enabled = false;
		this.missileUserInterface.blockageStrength.enabled = false;
		this.missileUserInterface.selectionPercent.enabled = false;
		this.missileUserInterface.mutationRatio.enabled = false;
		this.missileUserInterface.numberOfChangeTry.enabled = false;
		this.missileUserInterface.originalPoolAmount.enabled = false;
		this.missileUserInterface.exitGeneration.enabled = false;
		this.missileUserInterface.mapWidth.enabled = false;
		this.missileUserInterface.mapHeight.enabled = false;
		this.missileUserInterface.cellLength.enabled = false;
	}

	public function lockGAUI() {
		this.missileUserInterface.selectionPercent.enabled = false;
		this.missileUserInterface.mutationRatio.enabled = false;
		this.missileUserInterface.numberOfChangeTry.enabled = false;
		this.missileUserInterface.originalPoolAmount.enabled = false;
		this.missileUserInterface.exitGeneration.enabled = false;
		this.missileUserInterface.numOfGene.enabled = false;
//		this.missileUserInterface.playButton.dynamicButton.setEnable(false);
	}

	public function startEvent(e:DynamicButton) {
		this.missileUserInterface.initMap();
		if (this.missileUserInterface.entityLocation == null || this.missileUserInterface.missileLocation == null) {
			this.mapSizeChangeEvent(null);

		} else {
			lockUI();

			function playEvent() {
				var fScene:FirstSettingScene = presentationManager.getCurrentView().scene as FirstSettingScene;


				var viewMap:MissileMap = missileUserInterface.missileMapData.copyMap();

				fScene.graphicWrapper.missileMap = viewMap;
				var movableEntity:AiMovableObject = new AiMovableObject(viewMap, missileUserInterface.playBlockage.selected, true);
				viewMap.setObjectByMapLocation(missileUserInterface.entityLocation, movableEntity);
				var missile:MissileObject = new MissileObject(viewMap, movableEntity, missileUserInterface.missileBlockage.selected, true);
				viewMap.setObjectByMapLocation(missileUserInterface.missileLocation, missile);
				fScene.graphicWrapper.drawObject();

				var t:Timer = new Timer(missileUserInterface.getPlayVelocity(), 0);
				var i:int = 0;
				var catchCheck:Boolean = false;
				var console:DefaultSizeLabel = new DefaultSizeLabel();
				missileUserInterface.addChild(console);
				t.addEventListener(TimerEvent.TIMER, function (e:TimerEvent) {
					//스톱 해주거라라
					if (catchCheck) {
						t.stop();
						return;
					}


					console.setText((i + 1) + "");

					var avoid:Boolean = movableEntity.avoidTarget(missile);
					missile.trackingTarget();
					var tracking:Boolean = missile.trackingTarget();

					fScene.graphicWrapper.drawObject();

					if (!avoid || !tracking || missile.getLocation() == null || movableEntity.getLocation() == null) {
						catchCheck = true;
						return;
					}
					i++;

				});
				t.start();


			};
			playEvent();
		}


	}

	public function getArrowSymbol(gene:DirectionGene):ArrowSymbol {
		var arrowSymbol:ArrowSymbol = new ArrowSymbol();
		switch (gene.direction) {
			case "EAST":
				arrowSymbol.rotation = 90;
				break;
			case "WEST":
				arrowSymbol.rotation = 270;
				break;
			case "SOUTH":
				arrowSymbol.rotation = 0;
				break;
			case "NORTH":
				arrowSymbol.rotation = 180;
				break;

		}
		return arrowSymbol;
	}

	public function moveActionEntity(gene:DirectionGene, entity:MovableObject) {
		switch (gene.direction) {
			case "EAST":
				entity.moveRight();
				break;
			case "WEST":
				entity.moveLeft();
				break;
			case "SOUTH":
				entity.moveDown();
				break;
			case "NORTH":
				entity.moveUp();
				break;

		}
	}

	public function MissileAI_GA() {

		this.presentationManager = new PresentationManager();
		this.missileUserInterface = new MissileUserInterfaceWrapper(this.presentationManager);
		addChild(this.missileUserInterface);
		addChild(this.presentationManager.presentationViewClip);
		var label:DefaultSizeLabel = new DefaultSizeLabel();
		label.setText("Missile Simulation for AI");
		label.y = 500;
		addChild(label);
		lockGAUI();
		initPresentation();
		this.presentationManager.start();
		this.missileUserInterface.startButton.dynamicButton.addEventButtonListener(startEvent);

		var ct:uint = 0;
		this.missileUserInterface.playButton.dynamicButton.addEventButtonListener(function saveData() {
			var fScene = presentationManager.getCurrentView().scene as FitnessScene;
			if (fScene) {
				return;
			}else{
				fScene = presentationManager.getCurrentView().scene;
			}
			var cMap:MissileMap = missileUserInterface.missileMapData.copyMap();
			if (ct == 0) {
				var sBuffer:String = "";
				for (var x:int = 0; x < cMap.mapData.length; x++) {
					for (var y:int = 0; y < cMap.mapData[x].length; y++) {
						var object = cMap.mapData[x][y];
						var objectCode:uint = 0;
						if (object as ClickSettingObject || object == null) {
							objectCode = 0;
						} else if (object as MissileObject) {
							objectCode = 2;
						} else if (object as AiMovableObject) {
							objectCode = 3;
						} else if (object as MovableObject) {
							objectCode = 1;
						}else if (object as BlockageObject) {
							objectCode = 4;
						}

						sBuffer = sBuffer.concat(objectCode);
					}
				}
				trace(sBuffer);
				ct++;
			} else if (ct == 1) {
				//
				var sBuffer:String = "";
				for (var x:int = 0; x < cMap.mapData.length; x++) {
					for (var y:int = 0; y < cMap.mapData[x].length; y++) {
						var object = cMap.mapData[x][y];
						var objectCode:uint = 0;
						if (object as ClickSettingObject || object == null) {
							objectCode = 0;
						} else if (object as MissileObject) {
							objectCode = 2;
						} else if (object as AiMovableObject) {
							objectCode = 3;
						} else if (object as MovableObject) {
							objectCode = 1;
						}else if (object as BlockageObject) {
							objectCode = 4;
						}

						sBuffer = sBuffer.concat(objectCode);
					}
				}
				trace(sBuffer);

				var mvObjectCache:MovableObject = null;
				var miObjectCache:MissileObject = null;
				var aiObjectCache:AiMovableObject = null;

				function getObject(code:uint) {
					switch (code) {
						case 0:
							return null;
							break;
						case 1:
							var s1:MovableObject = new MovableObject(missileUserInterface.missileMapData, missileUserInterface.playBlockage.selected, true);
							mvObjectCache = s1;
							return s1;
						case 2:
							var s2:MissileObject = new MissileObject(missileUserInterface.missileMapData, null, missileUserInterface.missileBlockage.selected, true);
							miObjectCache = s2;
							return s2;

						case 3:
							var s3:AiMovableObject = new AiMovableObject(missileUserInterface.missileMapData, missileUserInterface.playBlockage.selected, true)
							aiObjectCache = s3;
							return s3;
						case 4:
							var s4:BlockageObject = new BlockageObject(missileUserInterface.missileMapData,missileUserInterface.blockageStrength.value, true);
							return s4;
					}

				}
				//

				var mapData = "0000004000044440404000004000000400004444040440000400000040000444400000000040000004000044440400000004000020400004444040000040000000040000400004000040000000000004040040400004000444444444400004040000400000000000040040404000444444444444444004040400000000000000000400404040000000044444444440040404000444440000000004004040400000000000000000400404040000000044444444440000004000000000000000004000000400000000000000000400004440004000000000000400000400000400000000000400000040401004000000000400000004000004000000000400000000404000040000000400000000040000040000000400000000004040000400000400000000000400000400000400000000000040400040000";
				var currentMapIndex:uint = 0;
				for (var x:int = 0; x < cMap.mapData.length; x++) {
					for (var y:int = 0; y < cMap.mapData[x].length; y++) {
						missileUserInterface.missileMapData.setObject(x,y,getObject(parseInt(mapData.charAt(currentMapIndex))))
						currentMapIndex++;
					}
				}
				if(miObjectCache){
					miObjectCache.targetObject = mvObjectCache;
				}
				(fScene as FirstSettingScene).graphicWrapper.drawObject();
			}

		});
	}


	public static function getBestEntity(missileTargetEntities:Vector.<MissileTargetEntity>):Entity {
		missileTargetEntities.sort(new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER).compare)
		return missileTargetEntities[0];
	}

	var mapSizeChangeEvent:Function = function (e:Event) {

		var missileMap:MissileMap = new MissileMap(missileUserInterface.getMapWidth(), missileUserInterface.getMapHeight(), true);
		missileMap.objectSize = missileUserInterface.getCellLength();
		missileUserInterface.missileMapData = missileMap;
		missileUserInterface.missileMapData.mapData = missileMap.mapData;
		firstScene.forceInit(firstScene.view);
	};

	public function initPresentation() {
		firstScene = new FirstSettingScene(this.missileUserInterface);
		//이벤트 등록?
		var settingView:View = new View(firstScene);

		this.missileUserInterface.mapWidth.addEventListener(Event.CHANGE, mapSizeChangeEvent);
		this.missileUserInterface.mapHeight.addEventListener(Event.CHANGE, mapSizeChangeEvent);
		this.missileUserInterface.cellLength.addEventListener(Event.CHANGE, mapSizeChangeEvent);
		this.presentationManager.presentationViews.push(settingView);
	}
}
}
