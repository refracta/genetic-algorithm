package com.wg.ga.starter.functionmax {

import bkde.as3.parsers.MathParser;

import com.refracta.view.BinaryGeneInformationView;

import com.refracta.view.DynamicButton;
import com.wg.ga.binary.manager.BinaryGeneManagerWrapper;
import com.wg.ga.framework.logic.interfaces.MutationLogic;
import com.wg.ga.expression.scene.functionmax.CreateFirstParentScene;
import com.wg.ga.expression.scene.functionmax.FinalAverageGraphViewScene;
import com.wg.ga.expression.scene.functionmax.FinalBestGeneInformationScene;
import com.wg.ga.expression.scene.functionmax.FinalGraphViewScene;
import com.wg.ga.expression.scene.functionmax.FirstGraphScene;
import com.wg.ga.expression.scene.functionmax.FullSizeLabelScene;
import com.wg.ga.expression.scene.functionmax.GraphViewScene;
import com.wg.ga.expression.ui.MainUserInterfaceWrapper;
import com.wg.ga.expression.scene.functionmax.CrossoverScene;
import com.wg.ga.expression.scene.functionmax.MutationScene;
import com.wg.ga.expression.scene.functionmax.SelectionLogicScene;
import com.wg.ga.binary.entity.BinaryEntity;
import com.wg.ga.binary.fm.BinaryFunctionFitnessMeasurment;
import com.wg.ga.binary.logic.impl.BinarySinglePointCrossoverLogic;
import com.wg.ga.binary.logic.impl.BinaryHighScoreRouletteWheelSelectionLogic;
import com.wg.ga.binary.logic.impl.BinaryMutateLogic;
import com.wg.ga.binary.manager.BinaryGeneManager;
import com.wg.ga.framework.entity.Entity;
import com.wg.ga.framework.logic.interfaces.CrossoverLogic;
import com.wg.ga.framework.logic.interfaces.ReproductionLogic;
import com.wg.ga.framework.logic.interfaces.SelectionLogic;
import com.wg.ga.framework.ordering.BasicEntityComparator;
import com.wg.ga.framework.ordering.BasicOrderingOption;
import com.wg.ga.framework.util.Random;
import com.wg.ga.framework.view.PresentationManager;
import com.wg.ga.framework.view.View;

import flash.display.MovieClip;
import flash.events.Event;
import flash.system.System;

[SWF(backgroundColor="0xffffff", width="501", height="720")]
public class GeneticAlgorithmGraphicWrapper extends MovieClip {
	private var mainUserInterface:MainUserInterfaceWrapper;
	private var presentationManager:PresentationManager;


	public function GeneticAlgorithmGraphicWrapper() {
		this.presentationManager = new PresentationManager();
		this.mainUserInterface = new MainUserInterfaceWrapper(this.presentationManager);
		addChild(this.mainUserInterface);
		addChild(this.presentationManager.presentationViewClip);
		initPresentation();
		this.presentationManager.start();
		this.mainUserInterface.startButton.dynamicButton.addEventButtonListener(startEvent);
	}

	public function startEvent(e:DynamicButton) {
		if (MathParser.isPossibleCompile(this.mainUserInterface.getFunctionText())) {
			e.setEnable(false);
			lockUI();
			startLogic();
		}
	}

	public function lockUI() {
		this.mainUserInterface.functionText.selectable = false;
		this.mainUserInterface.selectionPercent.enabled = false;
		this.mainUserInterface.mutationRatio.enabled = false;
		this.mainUserInterface.numberOfChangeTry.enabled = false;
		this.mainUserInterface.originalPoolAmount.enabled = false;
		this.mainUserInterface.exitGeneration.enabled = false;
	}

	public static function getBestEntity(binaryEntities:Vector.<BinaryEntity>):Entity {
		binaryEntities.sort(new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER).compare)
		return binaryEntities[0];
	}

	public function startLogic() {
		var generationBestEntity:Vector.<BinaryEntity> = new Vector.<BinaryEntity>();
		var geneManager:BinaryGeneManagerWrapper = new BinaryGeneManagerWrapper(this.mainUserInterface);
		var crossoverLogic:BinarySinglePointCrossoverLogic = new BinarySinglePointCrossoverLogic();
		var selectionLogic:SelectionLogic = new BinaryHighScoreRouletteWheelSelectionLogic(this.mainUserInterface.getSelectionPercent(), true);
		var binaryMutateLogic:BinaryMutateLogic = new BinaryMutateLogic(this.mainUserInterface.getNumberOfChangeTry());
		var entityGroup:Vector.<BinaryEntity> = geneManager.getFirstLimitBinaryEntitys(new BinaryFunctionFitnessMeasurment(this.mainUserInterface.getFunctionText()), this.mainUserInterface.binarySize, this.mainUserInterface.getOriginalPoolAmount());
		var es:BasicEntityComparator = new BasicEntityComparator(BasicOrderingOption.DESCENDING_ORDER);
		var functionValueAverageVector:Vector.<Number> = new Vector.<Number>();
		entityGroup.sort(es.compare);
		trace("Create First EntityGroups");
		trace(entityGroup);
		var createParentView:View = new View(new CreateFirstParentScene(entityGroup));
		this.presentationManager.presentationViews.push(createParentView);
		var firstGraphViewScene:GraphViewScene = new GraphViewScene(this.mainUserInterface, entityGroup);
		var firstGraphView:View = new View(firstGraphViewScene);
		this.presentationManager.presentationViews.push(firstGraphView);
		var binaryEntities:Vector.<BinaryEntity> = Vector.<BinaryEntity>(selectionLogic.getSelectGene(Vector.<Entity>(entityGroup)));
		binaryEntities.sort(es.compare);
		this.presentationManager.presentationViews.push(new View(new SelectionLogicScene(BinaryHighScoreRouletteWheelSelectionLogic(selectionLogic), entityGroup, binaryEntities)));
		var randomIndexCrossoverViewEntities:Vector.<Vector.<BinaryEntity>> = geneManager.getViewParameterRandomIndexCrossoverEntities(crossoverLogic, binaryEntities);
		this.presentationManager.presentationViews.push(new View(new CrossoverScene(randomIndexCrossoverViewEntities)));
		var reproductionEntity:Vector.<BinaryEntity> = geneManager.getFilteredEntities(randomIndexCrossoverViewEntities);
		var mutationWithView:Vector.<Vector.<BinaryEntity>> = geneManager.setMutateEntityWithView(binaryMutateLogic, reproductionEntity);
		this.presentationManager.presentationViews.push(new View(new MutationScene(mutationWithView)));
		this.presentationManager.presentationViews.push(new View(new GraphViewScene(this.mainUserInterface, reproductionEntity)));
		this.presentationManager.presentationViews.push(new View(new FullSizeLabelScene("\n\n1세대 시작\nGo!")));
		generationBestEntity.push(getBestEntity(reproductionEntity));
		functionValueAverageVector.push(getAverageFunctionValue(reproductionEntity));
		trace("진화 종료 : " + this.mainUserInterface.getExitGeneration())
		for (var i:int = 1; i < this.mainUserInterface.getExitGeneration() + 1; i++) {
			var selectionEntities:Vector.<BinaryEntity> = Vector.<BinaryEntity>(selectionLogic.getSelectGene(Vector.<Entity>(reproductionEntity)));
			selectionEntities.sort(es.compare);
			this.presentationManager.presentationViews.push(new View(new SelectionLogicScene(BinaryHighScoreRouletteWheelSelectionLogic(selectionLogic), entityGroup, binaryEntities)));
			var crossoverViewData:Vector.<Vector.<BinaryEntity>> = geneManager.getViewParameterRandomIndexCrossoverEntities(crossoverLogic, selectionEntities);
			this.presentationManager.presentationViews.push(new View(new CrossoverScene(crossoverViewData)));
			reproductionEntity = geneManager.getFilteredEntities(crossoverViewData);
			var mutationData:Vector.<Vector.<BinaryEntity>> = geneManager.setMutateEntityWithView(binaryMutateLogic, reproductionEntity);
			this.presentationManager.presentationViews.push(new View(new MutationScene(mutationData)));
			this.presentationManager.presentationViews.push(new View(new GraphViewScene(this.mainUserInterface, reproductionEntity)));
			generationBestEntity.push(getBestEntity(reproductionEntity));
			functionValueAverageVector.push(getAverageFunctionValue(reproductionEntity));
			if (i == this.mainUserInterface.getExitGeneration()) {
				this.presentationManager.presentationViews.push(new View(new FullSizeLabelScene("\n\n시뮬레이션이\n종료되었습니다.")));
				this.presentationManager.presentationViews.push(new View(new FullSizeLabelScene("\n\n통계")));
				this.presentationManager.presentationViews.push(new View(new FinalBestGeneInformationScene(generationBestEntity)));
				this.presentationManager.presentationViews.push(new View(new FullSizeLabelScene("\n세대별 \n최고 개체\n변화 그래프\n(진할수록 후세대)")));
				this.presentationManager.presentationViews.push(new View(new FinalGraphViewScene(this.mainUserInterface, generationBestEntity)));
				this.presentationManager.presentationViews.push(new View(new FullSizeLabelScene("\n세대별\n평균 함수값\n그래프")));
				this.presentationManager.presentationViews.push(new View(new FinalAverageGraphViewScene(this.mainUserInterface, functionValueAverageVector)));
			} else {
				this.presentationManager.presentationViews.push(new View(new FullSizeLabelScene("\n\n" + (i + 1) + "세대 시작\nGo!")));

			}
		}
	}

	public function getAverageFunctionValue(entities:Vector.<BinaryEntity>) {
		var fValueTotal = 0;
		for (var i:int = 0; i < entities.length; i++) {
			fValueTotal += entities[i].getTotalGeneFitness();
		}
		fValueTotal = fValueTotal / entities.length;
		return fValueTotal;
	}

	//랜덤인덱스된 새끼들도 래핑되어 나오는 뷰 파라미터용 함수를 만듬 -> 호출 -> 뷰한테 가따주고 거르는 함수 만들어서 가따 쓴다


	public function initPresentation() {
		var firstGraphScene:FirstGraphScene = new FirstGraphScene(this.mainUserInterface);
		var firstGraphView:View = new View(firstGraphScene);
		this.presentationManager.presentationViews.push(firstGraphView);

		var realtimeGraphCreator:Function = function draw(e:Event) {
			if (presentationManager.currentView == 0) {
				mainUserInterface.drawSettingGraph(firstGraphScene.graphingBoard);
			}
		};
		var graphRangeChange:Function = function change(e:Event) {
			realtimeGraphCreator(null);
		};
		//start 먹일떄 prt 이동시키고 리스너 제거하고 매니저 벡터에서 제거

		this.mainUserInterface.xMaxLimit.addEventListener(Event.CHANGE, graphRangeChange);
		this.mainUserInterface.yMaxLimit.addEventListener(Event.CHANGE, graphRangeChange);
		this.mainUserInterface.functionText.addEventListener(Event.CHANGE, realtimeGraphCreator);
	}


}
}
