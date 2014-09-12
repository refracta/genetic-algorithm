package com.wg.ga.physical.world {


import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

import flash.display.Sprite;
import flash.events.Event;

public class BaseWorld extends Sprite {




	// world

	protected var world:b2World;                // BOX2D 물리 세계

	protected var gravity:b2Vec2;               // ( 2D 공간의 물리적인 힘 ) 중력과 비슷한 당기는 힘 x, y 로 정의.

	protected var scale:Number;                 // 물리공간과 플래시의 해상도?  Distance 1 / 30;

	protected var doSleep:Boolean               // 더이상 힘을 받지 않을 경우 sleep 모드 설정


	// dbg Draw

	protected var dbgSprite:Sprite;             // 디버그 드로우 할 공간

	protected var dbgDraw:b2DebugDraw;          // 디버그 드로우 관련


	// body, fixture - world 에 담을 객체들 이라고 생각 하면 된다.

	protected var body:b2Body;                  // 물체를 담을 바디

	protected var bodyDef:b2BodyDef;            // 바디 정의

	protected var fixtureDef:b2FixtureDef;      // 물체 형태 정의


	// real material

	protected var box:b2PolygonShape;           // 다각형


	protected var velocityIterations:Number;    // 강제로 속도를 컨트롤하는 힘.

	protected var positionIterations:Number;    // 강제로 위치를 컨트롤하는 힘.


	/**

	 *

	 * @param scale                  : 해상도

	 * @param velocityIterations     : 강제로 속도를 컨트롤하는 힘.

	 * @param positionIterations     : 강제로 위치를 컨트롤하는 힘.

	 *

	 */

	public function BaseWorld(scale:Number = 30, velocityIterations:Number = 10, positionIterations:Number = 10) {


		this.scale = scale;

		this.velocityIterations = this.velocityIterations;

		this.positionIterations = this.positionIterations;

		super();

	}


	protected function startUpdate():void {

		// 셋팅된 값에 따라 계속 업데이트.

		this.addEventListener(Event.ENTER_FRAME, onUpdate);

	}


	protected function stopUpdate():void {

		// 셋팅된 값에 따라 계속 업데이트 스톱

		this.removeEventListener(Event.ENTER_FRAME, onUpdate);

	}


	protected function setTheWorld(gravityX:Number, gravityY:Number):void {

		// 중력 , 스케일(해상도) , doSleep 등 물리세계 기본 설정

		this.gravity = new b2Vec2();

		this.gravity.x = 0;   // x쪽으로 작동하는 당기는 힘은 없음.

		this.gravity.y = 10;  // y 쪽으로 +10 ( 아래로 10 ) 만큼 당기는 힘이 존재

		this.doSleep = true;

		this.world = new b2World(this.gravity, this.doSleep);


		// 그릴 데이터를 셋팅.

		this.dbgDrawSetting();

	}


	protected function makeWall():void {

		//-------- 순서대로 위, 오른쪽, 아래, 왼쪽 ----------//

		// 두께

		var aryWidth:Array = [ stage.stageWidth, 1, stage.stageWidth, 1 ];

		var aryHeight:Array = [ 1, stage.stageHeight, 1, stage.stageHeight ];


		// 시작점

		var aryMoveToX:Array = [0, stage.stageWidth, 0, -2];

		var aryMoveToY:Array = [-2, 0, stage.stageHeight, 0];


		this.makeBox(aryWidth[0], aryHeight[0], aryMoveToX[0], aryMoveToY[0]); // 위

		this.makeBox(aryWidth[1], aryHeight[1], aryMoveToX[1], aryMoveToY[1]); // 오른쪽

		this.makeBox(aryWidth[2], aryHeight[2], aryMoveToX[2], aryMoveToY[2]); // 아래

		this.makeBox(aryWidth[3], aryHeight[3], aryMoveToX[3], aryMoveToY[3]); // 왼쪽

	}


	/**

	 *

	 * @param aryWidth  : 너비

	 * @param aryHeight : 높이

	 * @param aryMoveToX       : 시작점 X

	 * @param aryMoveToY       : 시작점 Y

	 *

	 */

	protected function makeBox(aryWidth:Number, aryHeight:Number, aryMoveToX:Number, aryMoveToY:Number):void {

		// 중심점 구하기 => Box2D 에서는 중심점 기준으로 사이즈*2 배로 그려진다는 점을 명심하자.

		var centerX:Number = aryMoveToX + ( aryWidth / 2 );

		var centerY:Number = aryMoveToY + ( aryHeight / 2 );


		// 바디 속성 정의

		this.bodyDef = new b2BodyDef();

		this.bodyDef.position.Set(centerX / this.scale, centerY / this.scale);


		// 박스 속성 정의

		this.box = new b2PolygonShape();

		this.box.SetAsBox(aryWidth / 2 / this.scale, aryHeight / 2 / this.scale);


		// shape 형태 정의

		this.fixtureDef = new b2FixtureDef();

		this.fixtureDef.shape = this.box;


		// 바디 생성 및 형태 생성

		this.body = this.world.CreateBody(this.bodyDef);

		this.body.CreateFixture(this.fixtureDef);

	}


	/**

	 *

	 * @param shape polygon, edge, circle 등 shape를 생성한 후 사이즈지정까지 완료하고 인자로 넣어 호출한다.

	 *

	 * ex ) 공일경우 : this.circle = new b2CircleShape( 30/30 ); makeMaterial( this.circle );

	 *

	 */

	protected function makeMaterial(shape:b2Shape, posX:Number = 0, posY:Number = 0, friction:Number = 0.05, density:Number = 5, restitution:Number = 0.7):void {

		// 물체 속성 선언

		this.fixtureDef = new b2FixtureDef();

		this.fixtureDef.shape = shape;                   // 형태는 위의 박스다.

		this.fixtureDef.friction = friction;                // 마찰

		this.fixtureDef.density = density;                 // 밀도

		this.fixtureDef.restitution = restitution;                   // 복원(력)


		// 바디 속성선언

		this.bodyDef = new b2BodyDef();

		this.bodyDef.type = b2Body.b2_dynamicBody;   // 움직이는 물체인가~? 그렇다면 dynamic

		this.bodyDef.allowSleep = true;                          // 물체 doSleep 설정

		this.bodyDef.position.Set(posX / this.scale, posY / this.scale);    // 물체의 시작 x , y 좌표


		// 실제 바디를 세계로 부터 생성

		this.body = this.world.CreateBody(this.bodyDef);


		// 바디에서 물체를 생성

		this.body.CreateFixture(this.fixtureDef);

	}


	/**

	 * debug_draw 셋팅하는 부분

	 *

	 * fillAlpha : 물체의 alpha 값

	 * lineThickness : outline 의 두께

	 * scale : 해상도 ( 1px당 몇 meter 인가? )

	 *

	 */





	protected function dbgDrawSetting(fillAlpha:Number = 0.5, lineThickness:Number = 1):void {

		// make debug world

		this.dbgSprite = new Sprite();                  // sprite 생성

		this.addChild(this.dbgSprite);              // sprite addchild


		this.dbgDraw = new b2DebugDraw();             // debug draw 생성


		// debug draw default properties setting - five

		this.dbgDraw.SetSprite(this.dbgSprite);            // 도화지 선택

		this.dbgDraw.SetFillAlpha(fillAlpha);              // 기본물체 알파값

		this.dbgDraw.SetLineThickness(lineThickness);             // 기본 물체 외곽선 두깨

		this.dbgDraw.SetDrawScale(this.scale);            // 기본 해상도 ( 스케일 )

		this.dbgDraw.SetFlags(b2DebugDraw.e_shapeBit);     // 드로잉 셋팅 기준


		// set debug world on the real world

		this.world.SetDebugDraw(this.dbgDraw);             // 실제 BOX2D에 무엇을 그릴지 설정.

	}


	/**

	 *

	 * @param e 엔터프레임으로 계속 reDebug_Drawing 하는 함수.

	 *

	 */

	protected function onUpdate(e:Event):void {

		// distance ( 해상도 )
		// velocityIterations ( 강제로 속도를 컨트롤하는 힘. )
		// positionIterations ( 강제로 위치를 컨트롤하는 힘. )
		//--------- Step( distance, velocityIterations, positionIterations ) ---------//

		this.world.Step(1 / this.scale, 10, 10);

		// 현재 등록된 힘 제거
		this.world.ClearForces();

		// 새로운 데이터 값을 그림.
		this.world.DrawDebugData();

	}


	/**
	 *
	 * @param num velocityIterations ( 강제로 속도를 컨트롤하는 힘. )
	 *
	 */

	protected function set setVelocityIterations(num:Number):void {

		this.velocityIterations = num;

	}


	/**
	 *
	 * @param num positionIterations ( 강제로 위치를 컨트롤하는 힘. )
	 *
	 */

	protected function set setPositionIterations(num:Number):void {

		this.positionIterations = num;

	}


	/**
	 *
	 * @param num scale ( 해상도 )
	 *
	 */

	protected function set setScale(num:Number):void {

		this.scale = num;

	}

}


}
