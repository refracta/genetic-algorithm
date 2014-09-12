/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 2:35
 */
package com.wg.ga.missile.fm {
import com.wg.ga.expression.ui.MissileUserInterfaceWrapper;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;
import com.wg.ga.missile.entity.MissileTargetEntity;
import com.wg.ga.framework.gene.DirectionGene;
import com.wg.ga.missile.map.MapLocation;
import com.wg.ga.missile.map.MissileMap;
import com.wg.ga.missile.map.MissileObject;
import com.wg.ga.missile.map.MovableObject;

public class TargetDistanceFitnessMeasurement implements FitnessMeasurement {
	private var missileMap:MissileMap;
	private var entityLocation:MapLocation;
	private var missileLocation:MapLocation;
	private var missileUserInterface:MissileUserInterfaceWrapper;
	public function TargetDistanceFitnessMeasurement(missileUserInterface:MissileUserInterfaceWrapper) {
		this.missileUserInterface = missileUserInterface;
		this.missileMap = this.missileUserInterface.missileMapData.copyMap();
		this.entityLocation = this.missileUserInterface.entityLocation;
		this.missileLocation = this.missileUserInterface.missileLocation;

	}

	public function getTotalGeneFitness(entity:Entity):Number {
		var copyMap:MissileMap = this.missileMap.copyMap();
		var movableEntity:MovableObject = new MovableObject(copyMap,missileUserInterface.playBlockage.selected, true);
		copyMap.setObjectByMapLocation(entityLocation, movableEntity);
		var missile:MissileObject = new MissileObject(copyMap, movableEntity,missileUserInterface.missileBlockage.selected ,true);
		copyMap.setObjectByMapLocation(missileLocation, missile);
		var castedEntity:MissileTargetEntity = MissileTargetEntity(entity);
		var information:Vector.<DirectionGene> = Vector.<DirectionGene>(castedEntity.getGeneInformation());
		var trackingIndex = 0;
		var isCreased:Boolean = false;
		for (var i:int = 0; i < information.length; i++) {
			var gene:DirectionGene = information[i];
			moveActionEntity(gene, movableEntity);
			missile.trackingTarget();
			var tracking:Boolean = missile.trackingTarget();
			if (!tracking || missile.getLocation() == null || movableEntity.getLocation() == null) {
				trackingIndex = i;
				isCreased = true;
				break;
			}
		}
		if (isCreased) {
			return -1 * (information.length - trackingIndex);
		} else {
			return MapLocation.getDistance(missile.getLocation(), movableEntity.getLocation());
		}

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


}
}
