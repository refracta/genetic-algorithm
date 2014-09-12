/**
 * 개발자 : refracta
 * 날짜   : 2014-08-24 오전 12:24
 */
package com.wg.ga.physical.element {
import Box2D.Dynamics.Contacts.b2Contact;
import Box2D.Dynamics.b2ContactListener;
import Box2D.Dynamics.b2Fixture;

public class ArriveContactListener extends b2ContactListener {
	override public virtual function BeginContact(contact:b2Contact):void {
		var fixtureA:b2Fixture = contact.GetFixtureA();
		var fixtureB:b2Fixture = contact.GetFixtureB();
		// if the fixture is a sensor, mark the parent body to be removed
		if (fixtureA.GetBody().GetUserData() == "ARRIVE" && fixtureB.GetBody().GetUserData() == "WAIT") {
			fixtureB.GetBody().SetUserData("CONTACTED");
		}else if(fixtureA.GetBody().GetUserData() == "WAIT" && fixtureB.GetBody().GetUserData() == "ARRIVE"){
			fixtureA.GetBody().SetUserData("CONTACTED");
		}


	}
}
}
