/**
 * 개발자 : refracta
 * 날짜   : 2014-08-19 오전 6:55
 */
package com.wg.ga.physical.world {
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Dynamics.Joints.b2MouseJoint;




public class ExtendsWorld extends BaseWorld {


	private var circle:b2CircleShape;

	private var polygon:b2PolygonShape;


	private var mx:Number;

	private var my:Number;

	private var mouseJoint:b2MouseJoint;

	private var mouseDown:Boolean;


	public function ExtendsWorld() {

		super(30, 10, 10);


		this.setTheWorld(0, 10);

		this.makeWall();

		this.startUpdate();


		// width, height, moveX, moveY

		this.makeBox(100, 30, 100, 300);


		var w:int;

		for (var i:int = 0; i < 30; i++) {

			w = int(Math.random() * 10) + 10;
			this.circle = new b2CircleShape(w / 30);
			this.makeMaterial(this.circle, 100, 100);

		}

	}


}
}
