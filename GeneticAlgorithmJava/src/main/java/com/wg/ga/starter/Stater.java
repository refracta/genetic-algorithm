package com.wg.ga.starter;

import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.fm.BinaryFunctionFitnessMeasurment;
import com.wg.ga.binary.logic.impl.BinaryMutateLogic;
import com.wg.ga.binary.logic.impl.BinarySinglePointCrossoverLogic;
import com.wg.ga.binary.manager.BinaryGeneManager;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.impl.HighScoreSelectionLogic;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.MutateLogic;
import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

/**
 * 개발자 : refracta
 * 날짜   : 2014-05-04 오전 1:39
 */
public class Stater {
	static int numberOfChangeTry = 10;
	static int numberOfCreateMutationPersent = 20;
	static int originalPoolAmount = 10;
	static int selectionPersent = 25;
	static int generation = 1000;
	static int binarySize = 8 * 2;

	//https://www.desmos.com/calculator
	static String absFunction = "-Math.abs(x - 75) + 50;";
	//y = -│x-75│+50
	//$y=-\abs \left(x-75\right)+50$

	static String quadraticFunction = "-0.01*Math.pow(x, 2) + 15*x - 5000;";
	//y = -0.01x^2 +15x -5000
	//$y=-0.01x^2+15x-5000$


	public static void main(String[] args) {

		StringBuffer jsFunction = new StringBuffer();
		jsFunction.append("return " + absFunction);


		BinaryGeneManager geneManager = new BinaryGeneManager();
		BinarySinglePointCrossoverLogic crossoverLogic = new BinarySinglePointCrossoverLogic();
		SelectionLogic highScoreSelectionLogic = new HighScoreSelectionLogic(selectionPersent);
		BinaryMutateLogic binaryMutateLogic = new BinaryMutateLogic(numberOfChangeTry);
		ArrayList<BinaryEntity> entityGroup = geneManager.getFirstLimitBinaryEntitys(new BinaryFunctionFitnessMeasurment(jsFunction.toString()), binarySize, originalPoolAmount);
		System.out.println("최초 집단을 생성합니다.");
		System.out.println(entityGroup);

		for (int i = 0; i < generation; i++) {
			System.out.println("\n\n\n");
			System.out.println(" " + i + "세대 출격!");
			System.out.println("선택 로직 작동");
			ArrayList<BinaryEntity> binaryEntities = (ArrayList<BinaryEntity>) highScoreSelectionLogic.getSelectGene(entityGroup);
			System.out.println("교차 로직 작동");
			ArrayList<BinaryEntity> randomIndexCrossoverEntities = getRandomIndexCrossoverEntities(crossoverLogic, binaryEntities);
			System.out.println("돌연변이 생성 로직 작동");
			setMutateEntity(binaryMutateLogic, randomIndexCrossoverEntities);
			entityGroup = randomIndexCrossoverEntities;
			System.out.println("현재 세대 : " + (i + 1));
			System.out.println("현재 세대 최고 적합도 개체: " + getBestEntity(entityGroup));
		}


	}

	public static Entity getBestEntity(ArrayList<BinaryEntity> binaryEntities) {
		Collections.sort(binaryEntities, new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER));
		return binaryEntities.get(0);
	}

	public static void setMutateEntity(MutateLogic mutateLogic, ArrayList<BinaryEntity> binaryEntities) {
		int selectIndex = ((int) (binaryEntities.size() * (numberOfCreateMutationPersent / 100.0)));
		for (int i = 0; i < selectIndex; i++) {
			int randomIndex = new Random().nextInt(binaryEntities.size());
			Entity mutation = mutateLogic.createMutation(binaryEntities.get(randomIndex));
			binaryEntities.set(randomIndex, (BinaryEntity) mutation);
		}
	}

	public static ArrayList<BinaryEntity> getRandomIndexCrossoverEntities(CrossoverLogic crossoverLogic, ArrayList<BinaryEntity> binaryEntities) {
		ArrayList<BinaryEntity> childEntities = new ArrayList<BinaryEntity>();
		int size = binaryEntities.size();
		Random random = new Random();
		if (size < 2) {
			try {
				throw new Exception("BinaryEntity list size is small");
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(1);
			}
		}
		for (int i = 0; i < originalPoolAmount; i++) {
			int randomIndex1 = random.nextInt(size);
			int randomIndex2 = random.nextInt(size);
			for (; randomIndex1 == randomIndex2; randomIndex1 = random.nextInt(size)) ;
			BinaryEntity source1 = binaryEntities.get(randomIndex1);
			BinaryEntity source2 = binaryEntities.get(randomIndex2);
			BinaryEntity crossoverEntity = (BinaryEntity) crossoverLogic.createCrossoverEntity(source1, source2);
			childEntities.add(crossoverEntity);
		}
		return childEntities;
	}
}


