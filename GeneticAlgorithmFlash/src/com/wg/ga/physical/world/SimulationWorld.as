/**
 * 개발자 : refracta
 * 날짜   : 2014-08-21 오후 4:40
 */
package com.wg.ga.physical.world {
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Common.Math.b2Mat22;
import Box2D.Common.Math.b2Transform;
import Box2D.Common.Math.b2Vec2;
import Box2D.Common.b2Color;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

import fl.transitions.easing.Elastic;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;

public class SimulationWorld {


	private var _view:MovieClip;
	private var _viewWidth:Number;
	private var _viewHeight:Number;

	public function SimulationWorld(viewWidth:Number, viewHeight:Number) {
		this._viewWidth = viewWidth;
		this._viewHeight = viewHeight;
		_view = new MovieClip();
		initAll();
	}

	public function initAll() {
		initWorld();
		initDrawSetting();
		initBedRock();
		initBlockageSetting();
	}

	private var _world:b2World;

	private var _verticalGravity:Number = 10;
	private var _horizontalGravity:Number = 0;

	public function initWorld() {
		var gravityVector:b2Vec2 = new b2Vec2(_horizontalGravity,_verticalGravity);
		this._world = new b2World(gravityVector, true);
	}

	private var _simulationView:Sprite;


	private var _debugDraw:b2DebugDraw;
	private var _debugSprite:Sprite;

	private var _drawPixelToMeterScale:Number = 32;
	private var _drawFillAlpha:Number = 0.5;
	private var _drawLineThickness:Number = 1;
	private var _drawFlags:uint = b2DebugDraw.e_shapeBit;


	public function initDrawSetting() {
		if (this._simulationView != null) {
			this._view.removeChild(this._simulationView);
		}
		this._simulationView = new Sprite();
		this._debugSprite = new Sprite();
		this._simulationView.addChild(this._debugSprite);
		this._view.addChild(this._simulationView);
		this._debugDraw = new b2DebugDraw();
		this._debugDraw.SetSprite(this._debugSprite);
		this._debugDraw.SetDrawScale(this._drawPixelToMeterScale);
		this._debugDraw.SetFillAlpha(this._drawFillAlpha);
		this._debugDraw.SetLineThickness(this._drawLineThickness);
		this._debugDraw.SetFlags(this._drawFlags);
		this._world.SetDebugDraw(this._debugDraw);
	}

	private var _topBedRockBodyDef:b2BodyDef;
	private var _topBedRockBoxShape:b2PolygonShape;
	private var _topBedRockFixtureDef:b2FixtureDef;
	private var _topBedRockBody:b2Body;

	private var _bottomBedRockBodyDef:b2BodyDef;
	private var _bottomBedRockBoxShape:b2PolygonShape;
	private var _bottomBedRockFixtureDef:b2FixtureDef;
	private var _bottomBedRockBody:b2Body;

	private var _rightBedRockBodyDef:b2BodyDef;
	private var _rightBedRockBoxShape:b2PolygonShape;
	private var _rightBedRockFixtureDef:b2FixtureDef;
	private var _rightBedRockBody:b2Body;

	private var _leftBedRockBodyDef:b2BodyDef;
	private var _leftBedRockBoxShape:b2PolygonShape;
	private var _leftBedRockFixtureDef:b2FixtureDef;
	private var _leftBedRockBody:b2Body;

	private var _bedRockThickness:Number = 1;
	private var _componentFriction:Number = 0.3;
	private var _componentGroupIndex:int = 1;

	public function initBedRock() {
		if (topBedRockBody != null) {
			this.world.DestroyBody(topBedRockBody);
		}
		if (bottomBedRockBody != null) {
			this.world.DestroyBody(bottomBedRockBody);
		}
		if (rightBedRockBody != null) {
			this.world.DestroyBody(rightBedRockBody);
		}
		if (leftBedRockBody != null) {
			this.world.DestroyBody(leftBedRockBody);
		}
		/*상단 생성*/
		this._topBedRockBodyDef = new b2BodyDef();

		this._topBedRockBodyDef.position.Set(this._viewWidth * 0.5 / this._drawPixelToMeterScale, 0);

		this._topBedRockBoxShape = new b2PolygonShape();
		this._topBedRockBoxShape.SetAsBox(this._viewWidth * 0.5 / this._drawPixelToMeterScale, this._bedRockThickness * 0.5 / this._drawPixelToMeterScale);

		this._topBedRockFixtureDef = new b2FixtureDef();
		this._topBedRockFixtureDef.shape = this._topBedRockBoxShape;
		this._topBedRockFixtureDef.filter.groupIndex = this._componentGroupIndex;
		this._topBedRockFixtureDef.friction = this._componentFriction;

		this._topBedRockBody = _world.CreateBody(this._topBedRockBodyDef);
		this._topBedRockBody.CreateFixture(this._topBedRockFixtureDef);

		/*하단 생성*/
		this._bottomBedRockBodyDef = new b2BodyDef();

		this._bottomBedRockBodyDef.position.Set(this._viewWidth * 0.5 / this._drawPixelToMeterScale, this._viewHeight / this._drawPixelToMeterScale);

		this._bottomBedRockBoxShape = new b2PolygonShape();
		this._bottomBedRockBoxShape.SetAsBox(this._viewWidth * 0.5 / this._drawPixelToMeterScale, 1 / this._drawPixelToMeterScale);

		this._bottomBedRockFixtureDef = new b2FixtureDef();
		this._bottomBedRockFixtureDef.shape = this._bottomBedRockBoxShape;
		this._bottomBedRockFixtureDef.filter.groupIndex = this._componentGroupIndex;
		this._bottomBedRockFixtureDef.friction = this._componentFriction;
		this._bottomBedRockBody = _world.CreateBody(this._bottomBedRockBodyDef);
		this._bottomBedRockBody.CreateFixture(this._bottomBedRockFixtureDef);

		/*좌측 생성*/
		this._leftBedRockBodyDef = new b2BodyDef();

		this._leftBedRockBodyDef.position.Set(0, this._viewHeight * 0.5 / this._drawPixelToMeterScale);

		this._leftBedRockBoxShape = new b2PolygonShape();
		this._leftBedRockBoxShape.SetAsBox(this._bedRockThickness * 0.5 / this._drawPixelToMeterScale, this._viewHeight * 0.5 / this._drawPixelToMeterScale);

		this._leftBedRockFixtureDef = new b2FixtureDef();
		this._leftBedRockFixtureDef.shape = this._leftBedRockBoxShape;
		this._leftBedRockFixtureDef.friction = this._componentFriction;
		this._leftBedRockFixtureDef.filter.groupIndex = this._componentGroupIndex;
		this._leftBedRockBody = _world.CreateBody(this._leftBedRockBodyDef);
		this._leftBedRockBody.CreateFixture(this._leftBedRockFixtureDef);

		/*우측 생성*/
		this._rightBedRockBodyDef = new b2BodyDef();
		this._rightBedRockBodyDef.position.Set(this._viewWidth / this._drawPixelToMeterScale, this._viewHeight * 0.5 / this._drawPixelToMeterScale);

		this._rightBedRockBoxShape = new b2PolygonShape();
		this._rightBedRockBoxShape.SetAsBox(this._bedRockThickness * 0.5 / this._drawPixelToMeterScale, this._viewHeight * 0.5 / this._drawPixelToMeterScale);

		this._rightBedRockFixtureDef = new b2FixtureDef();
		this._rightBedRockFixtureDef.shape = this._rightBedRockBoxShape;
		this._rightBedRockFixtureDef.filter.groupIndex = this._componentGroupIndex
		this._rightBedRockFixtureDef.friction = this._componentFriction;
		this._rightBedRockBody = _world.CreateBody(this._rightBedRockBodyDef);
		this._rightBedRockBody.CreateFixture(this._rightBedRockFixtureDef);
	}

	private var _blockageBodes:Vector.<b2Body>;

	public function initBlockageSetting() {
		this._blockageBodes = new Vector.<b2Body>();
	}


	private var _blockageSize:Number = 10.0;

	public function clearBlockages() {
		for (var i:int = 0; i < _blockageBodes.length; i++) {
			this._world.DestroyBody(_blockageBodes[i]);
		}
		_blockageBodes = new Vector.<b2Body>();
	}

	public function addBlockage(xPos:Number, yPos:Number):b2Body {
		var blockageBodyDef:b2BodyDef = new b2BodyDef();

		blockageBodyDef.position.Set(xPos / this._drawPixelToMeterScale, yPos / this._drawPixelToMeterScale);

		var blockageBoxShape:b2PolygonShape = new b2PolygonShape();
		blockageBoxShape.SetAsBox(this._blockageSize * 0.5 / this._drawPixelToMeterScale, this._blockageSize * 0.5 / this._drawPixelToMeterScale);

		var blockageFixtureDef:b2FixtureDef = new b2FixtureDef();
		blockageFixtureDef.shape = blockageBoxShape;
		blockageFixtureDef.filter.groupIndex = this._componentGroupIndex;
		blockageFixtureDef.friction = this._componentGroupIndex;
		var blockageBody:b2Body = _world.CreateBody(blockageBodyDef);
		blockageBody.CreateFixture(blockageFixtureDef);
		_blockageBodes.push(blockageBody);
		return blockageBody;
	}

	private var _arrivalPoint:b2Body;
	private var _arriveGroupIndex:uint = 1;
	public function setArrivalPoint(xPos:Number, yPos:Number) {
		if (_arrivalPoint != null) {
			this._world.DestroyBody(_arrivalPoint);
		}
		var arrivalPointBodyDef:b2BodyDef = new b2BodyDef();

		arrivalPointBodyDef.position.Set(xPos / this._drawPixelToMeterScale, yPos / this._drawPixelToMeterScale);

		var arrivalPointShape:b2PolygonShape = new b2PolygonShape();
		arrivalPointShape.SetAsBox(12.5 / this._drawPixelToMeterScale, 5 / this._drawPixelToMeterScale);
		var arrivalPointFixtureDef:b2FixtureDef = new b2FixtureDef();
		arrivalPointFixtureDef.shape = arrivalPointShape;
		arrivalPointFixtureDef.filter.groupIndex = this._arriveGroupIndex;
		var arrivalPointBody:b2Body = _world.CreateBody(arrivalPointBodyDef);
		arrivalPointBody.CreateFixture(arrivalPointFixtureDef);

		_arrivalPoint = arrivalPointBody;
	}

	private var _pointBall:b2Body = null;
	private var _ballGroupIndex:Number = -1;

	private var _ballFriction:Number = 0;
	private var _ballElasticity:Number = 0.75;
	private var _ballDensity:Number = 0;
	private var _ballLocationCache:b2Vec2 = null;
	private var _ballList:Vector.<b2Body> = new Vector.<b2Body>();
	private var _ballRadius:Number = 1;

	public function set ballRadius(value:Number):void {
		_ballRadius = value;
	}

	public function get ballRadius():Number {
		return _ballRadius;
	}

	public function setPointBall(ballSize:Number, xPos:Number, yPos:Number) {

		if (_pointBall != null) {
			this._world.DestroyBody(_pointBall);
		}
		var pointBallBodyDef:b2BodyDef = new b2BodyDef();

		pointBallBodyDef.position.Set(xPos / this._drawPixelToMeterScale, yPos / this._drawPixelToMeterScale);

		var pointBallShape:b2CircleShape = new b2CircleShape(ballSize / this._drawPixelToMeterScale);

		var pointBallFixtureDef:b2FixtureDef = new b2FixtureDef();
		pointBallFixtureDef.shape = pointBallShape;
		pointBallFixtureDef.filter.groupIndex = this._componentGroupIndex;
		pointBallFixtureDef.friction = this._componentGroupIndex;
		var pointBallBody:b2Body = _world.CreateBody(pointBallBodyDef);
		pointBallBody.CreateFixture(pointBallFixtureDef);

		_pointBall = pointBallBody;
	}
	public function clearBalls(){
		for (var i:int = 0; i < _ballList.length; i++) {
			if(_ballList[i]!=null){
			this._world.DestroyBody(_ballList[i]);
			}
		}
		_ballList = new Vector.<b2Body>();
	}

	public function addBall():b2Body {
		var circleBodyDef:b2BodyDef = new b2BodyDef();

		circleBodyDef.position.SetV(this.ballLocationCache);
		circleBodyDef.type = b2Body.b2_dynamicBody;
		var circleShape:b2CircleShape = new b2CircleShape(this._ballRadius);
		var circleFixture = new b2FixtureDef();

		circleFixture.shape = circleShape;
		circleFixture.friction = this.ballFriction;
		circleFixture.density = this.ballDensity;
		circleFixture.restitution = this.ballElasticity;
		circleFixture.filter.groupIndex = this._ballGroupIndex;


		var circleBody:b2Body = world.CreateBody(circleBodyDef);
		circleBody.CreateFixture(circleFixture);
		this.ballList.push(circleBody);
		return circleBody;
	}

	private var _velocityIterations:uint = 10;
	private var _positionIterations:uint = 10;
	private var _stepTime:Number = 0.1;

	public function update() {
		_world.Step(_stepTime, _velocityIterations, _positionIterations);
		_world.ClearForces();
		_world.DrawDebugData();
	}

	public function nonDrawUpdate() {
		_world.Step(_stepTime, _velocityIterations, _positionIterations);
		_world.ClearForces();
	}

	private var _dragC:Number;
	private var _pressure:Number;
	private var _objectArea:Number;


	public function getAirResistanceVector(currentVelocity:b2Vec2) {
		var xVector = getAirResistanceForceValue(this._dragC, this._pressure, _objectArea, currentVelocity.x);
		var yVector = getAirResistanceForceValue(this._dragC, this._pressure, _objectArea, currentVelocity.y);
		var resistanceVector:b2Vec2 = new b2Vec2(xVector, yVector);
		return resistanceVector;
	}

	public function getAirResistanceForceValue(dragC:Number, pressure:Number, objectArea:Number, forceValue:Number) {
		return -1 * 0.5 * dragC * pressure * objectArea * forceValue;
	}

	/*Getter Setter*/
	{

		public function get drawPixelToMeterScale():Number {
			return _drawPixelToMeterScale;
		}

		public function get view():MovieClip {
			return _view;
		}

		public function set view(value:MovieClip):void {
			_view = value;
		}

		public function get viewWidth():Number {
			return _viewWidth;
		}

		public function set viewWidth(value:Number):void {
			_viewWidth = value;
		}

		public function get viewHeight():Number {
			return _viewHeight;
		}

		public function set viewHeight(value:Number):void {
			_viewHeight = value;
		}

		public function get world():b2World {
			return _world;
		}

		public function set world(value:b2World):void {
			_world = value;
		}


		public function get verticalGravity():Number {
			return _verticalGravity;
		}

		public function set verticalGravity(value:Number):void {
			_verticalGravity = value;
		}

		public function get horizontalGravity():Number {
			return _horizontalGravity;
		}

		public function set horizontalGravity(value:Number):void {
			_horizontalGravity = value;
		}

		public function get simulationView():Sprite {
			return _simulationView;
		}

		public function set simulationView(value:Sprite):void {
			_simulationView = value;
		}

		public function get debugDraw():b2DebugDraw {
			return _debugDraw;
		}

		public function set debugDraw(value:b2DebugDraw):void {
			_debugDraw = value;
		}

		public function get debugSprite():Sprite {
			return _debugSprite;
		}

		public function set debugSprite(value:Sprite):void {
			_debugSprite = value;
		}

		public function get drawFillAlpha():Number {
			return _drawFillAlpha;
		}

		public function set drawFillAlpha(value:Number):void {
			_drawFillAlpha = value;
		}

		public function get drawLineThickness():Number {
			return _drawLineThickness;
		}

		public function set drawLineThickness(value:Number):void {
			_drawLineThickness = value;
		}

		public function get drawFlags():uint {
			return _drawFlags;
		}

		public function set drawFlags(value:uint):void {
			_drawFlags = value;
		}

		public function get topBedRockBodyDef():b2BodyDef {
			return _topBedRockBodyDef;
		}

		public function set topBedRockBodyDef(value:b2BodyDef):void {
			_topBedRockBodyDef = value;
		}

		public function get topBedRockBoxShape():b2PolygonShape {
			return _topBedRockBoxShape;
		}

		public function set topBedRockBoxShape(value:b2PolygonShape):void {
			_topBedRockBoxShape = value;
		}

		public function get topBedRockFixtureDef():b2FixtureDef {
			return _topBedRockFixtureDef;
		}

		public function set topBedRockFixtureDef(value:b2FixtureDef):void {
			_topBedRockFixtureDef = value;
		}

		public function get topBedRockBody():b2Body {
			return _topBedRockBody;
		}

		public function set topBedRockBody(value:b2Body):void {
			_topBedRockBody = value;
		}

		public function get bottomBedRockBodyDef():b2BodyDef {
			return _bottomBedRockBodyDef;
		}

		public function set bottomBedRockBodyDef(value:b2BodyDef):void {
			_bottomBedRockBodyDef = value;
		}

		public function get bottomBedRockBoxShape():b2PolygonShape {
			return _bottomBedRockBoxShape;
		}

		public function set bottomBedRockBoxShape(value:b2PolygonShape):void {
			_bottomBedRockBoxShape = value;
		}

		public function get bottomBedRockFixtureDef():b2FixtureDef {
			return _bottomBedRockFixtureDef;
		}

		public function set bottomBedRockFixtureDef(value:b2FixtureDef):void {
			_bottomBedRockFixtureDef = value;
		}

		public function get bottomBedRockBody():b2Body {
			return _bottomBedRockBody;
		}

		public function set bottomBedRockBody(value:b2Body):void {
			_bottomBedRockBody = value;
		}

		public function get rightBedRockBodyDef():b2BodyDef {
			return _rightBedRockBodyDef;
		}

		public function set rightBedRockBodyDef(value:b2BodyDef):void {
			_rightBedRockBodyDef = value;
		}

		public function get rightBedRockBoxShape():b2PolygonShape {
			return _rightBedRockBoxShape;
		}

		public function set rightBedRockBoxShape(value:b2PolygonShape):void {
			_rightBedRockBoxShape = value;
		}

		public function get rightBedRockFixtureDef():b2FixtureDef {
			return _rightBedRockFixtureDef;
		}

		public function set rightBedRockFixtureDef(value:b2FixtureDef):void {
			_rightBedRockFixtureDef = value;
		}

		public function get rightBedRockBody():b2Body {
			return _rightBedRockBody;
		}

		public function set rightBedRockBody(value:b2Body):void {
			_rightBedRockBody = value;
		}

		public function get leftBedRockBodyDef():b2BodyDef {
			return _leftBedRockBodyDef;
		}

		public function set leftBedRockBodyDef(value:b2BodyDef):void {
			_leftBedRockBodyDef = value;
		}

		public function get leftBedRockBoxShape():b2PolygonShape {
			return _leftBedRockBoxShape;
		}

		public function set leftBedRockBoxShape(value:b2PolygonShape):void {
			_leftBedRockBoxShape = value;
		}

		public function get leftBedRockFixtureDef():b2FixtureDef {
			return _leftBedRockFixtureDef;
		}

		public function set leftBedRockFixtureDef(value:b2FixtureDef):void {
			_leftBedRockFixtureDef = value;
		}

		public function get leftBedRockBody():b2Body {
			return _leftBedRockBody;
		}

		public function set leftBedRockBody(value:b2Body):void {
			_leftBedRockBody = value;
		}

		public function get bedRockThickness():Number {
			return _bedRockThickness;
		}

		public function set bedRockThickness(value:Number):void {
			_bedRockThickness = value;
		}

		public function get componentFriction():Number {
			return _componentFriction;
		}

		public function set componentFriction(value:Number):void {
			_componentFriction = value;
		}

		public function get componentGroupIndex():int {
			return _componentGroupIndex;
		}

		public function set componentGroupIndex(value:int):void {
			_componentGroupIndex = value;
		}

		public function get blockageBodes():Vector.<b2Body> {
			return _blockageBodes;
		}

		public function set blockageBodes(value:Vector.<b2Body>):void {
			_blockageBodes = value;
		}

		public function get blockageSize():Number {
			return _blockageSize;
		}

		public function set blockageSize(value:Number):void {
			_blockageSize = value;
		}

		public function get arrivalPoint():b2Body {
			return _arrivalPoint;
		}

		public function set arrivalPoint(value:b2Body):void {
			_arrivalPoint = value;
		}

		public function get arriveGroupIndex():uint {
			return _arriveGroupIndex;
		}

		public function set arriveGroupIndex(value:uint):void {
			_arriveGroupIndex = value;
		}

		public function get pointBall():b2Body {
			return _pointBall;
		}

		public function set pointBall(value:b2Body):void {
			_pointBall = value;
		}

		public function get ballGroupIndex():Number {
			return _ballGroupIndex;
		}

		public function set ballGroupIndex(value:Number):void {
			_ballGroupIndex = value;
		}

		public function get ballFriction():Number {
			return _ballFriction;
		}

		public function set ballFriction(value:Number):void {
			_ballFriction = value;
		}

		public function get ballElasticity():Number {
			return _ballElasticity;
		}

		public function set ballElasticity(value:Number):void {
			_ballElasticity = value;
		}

		public function get ballDensity():Number {
			return _ballDensity;
		}

		public function set ballDensity(value:Number):void {
			_ballDensity = value;
		}

		public function get ballLocationCache():b2Vec2 {
			return _ballLocationCache;
		}

		public function set ballLocationCache(value:b2Vec2):void {
			_ballLocationCache = value;
		}

		public function get ballList():Vector.<b2Body> {
			return _ballList;
		}

		public function set ballList(value:Vector.<b2Body>):void {
			_ballList = value;
		}

		public function get velocityIterations():uint {
			return _velocityIterations;
		}

		public function set velocityIterations(value:uint):void {
			_velocityIterations = value;
		}

		public function get positionIterations():uint {
			return _positionIterations;
		}

		public function set positionIterations(value:uint):void {
			_positionIterations = value;
		}

		public function get stepTime():Number {
			return _stepTime;
		}

		public function set stepTime(value:Number):void {
			_stepTime = value;
		}

		public function get dragC():Number {
			return _dragC;
		}

		public function set dragC(value:Number):void {
			_dragC = value;
		}

		public function get pressure():Number {
			return _pressure;
		}

		public function set pressure(value:Number):void {
			_pressure = value;
		}

		public function get objectArea():Number {
			return _objectArea;
		}

		public function set drawPixelToMeterScale(value:Number):void {
			_drawPixelToMeterScale = value;
		}

		public function set objectArea(value:Number):void {
			_objectArea = value;
		}

	}


}
}
