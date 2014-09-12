/**
 * 개발자 : refracta
 * 날짜   : 2014-08-15 오전 12:27
 */
package com.wg.ga.framework.gene {
import com.wg.ga.framework.gene.Gene;

public final class DirectionGene implements Gene {
	public static const EAST:DirectionGene = new DirectionGene("EAST");
	public static const WEST:DirectionGene = new DirectionGene("WEST");
	public static const SOUTH:DirectionGene = new DirectionGene("SOUTH");
	public static const NORTH:DirectionGene = new DirectionGene("NORTH");
	public static const GENE_LIST:Vector.<DirectionGene> = new <DirectionGene>[EAST, WEST, SOUTH, NORTH];
	private var _direction:String;

	public function get direction():String {
		return _direction;
	}

	public function getSimpleSign():String {
		switch (this._direction) {
			case "EAST":
				return "←";
				break;
			case "WEST":
				return "→";
				break;
			case "SOUTH":
				return "↓";
				break;
			case "NORTH":
				return "↑";
				break;
		}
		return null;
	}

	public function DirectionGene(direction:String) {
		this._direction = direction;
	}

	public function equals(directionGene:DirectionGene) {
		return (directionGene.direction == this.direction);
	}
}
}
