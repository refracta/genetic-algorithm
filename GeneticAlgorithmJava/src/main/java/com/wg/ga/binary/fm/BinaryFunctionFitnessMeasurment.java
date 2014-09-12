package com.wg.ga.binary.fm;

import com.refracta.framework.javascript.NashornWrapper;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.fm.FitnessMeasurement;

import javax.script.ScriptContext;
import javax.script.ScriptEngineManager;

/**
 * 개발자 : refracta
 * 날짜   : 2014-07-28 오전 4:32
 */
public class BinaryFunctionFitnessMeasurment implements FitnessMeasurement {
	private String javaScriptFunction;

	public BinaryFunctionFitnessMeasurment(String javaScriptFunction) {
		this.javaScriptFunction = javaScriptFunction;
	}

	@Override
	public double getTotalGeneFitness(Entity entity) {
		BinaryEntity binaryEntity = (BinaryEntity) entity;
		NashornWrapper nashornWrapper = new NashornWrapper();
		nashornWrapper.setScriptEngine(new ScriptEngineManager().getEngineByName("javascript"));
		StringBuffer script = new StringBuffer();
		nashornWrapper.setAttribute("x",binaryEntity.getDexNumber(), ScriptContext.ENGINE_SCOPE);
		script.append("function f(){" + "\n");
		script.append(this.javaScriptFunction + "\n");
		script.append("}" + "\n");
		nashornWrapper.eval(script.toString());
		return Double.parseDouble(nashornWrapper.invokeFunction("f"));
	}
}
