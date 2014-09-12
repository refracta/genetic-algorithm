package com.wg.ga.starter.phycical {
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

import com.wg.ga.framework.util.Random;

import com.wg.ga.physical.world.BaseWorld;
import com.wg.ga.physical.world.ExtendsWorld;


import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

[SWF(width='500', height='500', backgroundColor='#ffffff', frameRate='30')]
public class AirResistance extends MovieClip {

	public function AirResistance() {
		this.addEventListener(Event.ADDED_TO_STAGE, stageInit);
	}

	public function stageInit(e:Event) {
		var gravityVector:b2Vec2 = new b2Vec2();
		gravityVector.x = 0;
		gravityVector.y = 9.8;
		var world:b2World = new b2World(gravityVector, true);


		var mySprite:Sprite = new Sprite();
		this.addChild(mySprite);
		var debugDraw:b2DebugDraw = new b2DebugDraw();
		var debugSprite:Sprite = new Sprite();
		mySprite.addChild(debugSprite);
		debugDraw.SetSprite(mySprite);
		debugDraw.SetDrawScale(30);
		debugDraw.SetFillAlpha(0.5);
		debugDraw.SetLineThickness(1);
		debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
		world.SetDebugDraw(debugDraw);


		var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set((60 / 30), ((this.stage.stageHeight) / 30) - 2);
			bodyDef.type = b2Body.b2_dynamicBody;

			var circle:b2CircleShape = new b2CircleShape(30 / 30);

			var fixtureDef = new b2FixtureDef();
			fixtureDef.shape = circle;
			fixtureDef.friction = 1;

			fixtureDef.density = 1;
			fixtureDef.restitution = 0.8;
			fixtureDef.filter.groupIndex = -1;


			var circleBody1:b2Body = world.CreateBody(bodyDef);
			circleBody1.CreateFixture(fixtureDef);

			circleBody1.ApplyForce(new b2Vec2(1000, -5500), circleBody1.GetWorldCenter());

			var circleBody2:b2Body = world.CreateBody(bodyDef);
			circleBody2.CreateFixture(fixtureDef);
			circleBody2.ApplyForce(new b2Vec2(1000, -5500), circleBody2.GetWorldCenter());


			bodyDef = new b2BodyDef();
			bodyDef.position.Set(0 / 30, (this.stage.stageHeight) / 30);
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox(this.stage.stageWidth / 30, 1 / 30);
			// shape 형태 정의
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = box;
			fixtureDef.filter.groupIndex = 1;

			//this.fixtureDef.density = 1; // 밀도
			// 바디 생성 및 형태 생성

			var fitBody = world.CreateBody(bodyDef);
			fitBody.CreateFixture(fixtureDef);


		var p:Number = 1.204;
		var dragC:Number = 0.2;
		var area:Number = 0.5 * 0.5 * Math.PI;

		function update(e:Event):void {

			// dt:Number - 초당 몇회 그릴것인지 설정, 반복속도 설정
			// velocityIterations:int - 반복 속도 설정
			// positionIterations:int - 포지션 반복
//			trace(v);

			world.Step(1 / 120, 3, 8);
			world.ClearForces();
			world.DrawDebugData();

			var calculX:Number = 0.5 * dragC * p * area * circleBody1.GetLinearVelocity().x;
			var calculY:Number = 0.5 * dragC * p * area * circleBody1.GetLinearVelocity().y;
			circleBody1.ApplyForce(new b2Vec2(-calculX, -calculY), circleBody1.GetWorldCenter());
			if(circleBody1.GetPosition().x>circleBody2.GetPosition().x){
				// trace("큼");
			}

		}

		this.addEventListener(Event.ENTER_FRAME, update);


	}

	// 엔터프레임


}
}
