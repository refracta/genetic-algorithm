/**
 * 개발자 : refracta
 * 날짜   : 2014-08-10 오전 3:04
 */
package com.wg.ga.framework.util {
public class CloneUtil {
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public static function cloneInstance(src:*):* {
		var className:String = getQualifiedClassName(src);
		try {
			getClassByAlias(className);
		} catch (e:ReferenceError) {
			registerClassAlias(className, getDefinitionByName(className) as Class);
		}

		var clone:ByteArray;
		clone = new ByteArray();
		clone.writeObject(src);
		clone.position = 0;
		return(clone.readObject());
	}
}
}
