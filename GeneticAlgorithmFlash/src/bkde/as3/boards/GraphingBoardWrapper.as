/**
 * 개발자 : refracta
 * 날짜   : 2014-08-06 오전 7:53
 */
package bkde.as3.boards {
import bkde.as3.parsers.CompiledObject;
import bkde.as3.parsers.MathParser;

public class GraphingBoardWrapper extends GraphingBoard {
	private var nPoints:Number = 640;


	public function setnPoints(value:Number):void {
		nPoints = value;

	}


//	gf.setVarsRanges(nXmin,nXmax,nYmin,nYmax);
	public function removeGraph(graphIndex:int):Boolean {

		if (graphIndex - 1 > 0 && graphIndex - 1 < aGraphs.length) {
			aGraphs[graphIndex - 1].graphics.clear();
			return true;
		} else {
			return false;
		}
	}

	//커스텀 펑션 기능
	public function drawFunction(functionString:String, graphIndex:int, thickN:Number, colorN:Number):Array {
		ErrorBox.visible = false;
		aGraphs[graphIndex - 1].graphics.clear();
		var procFun:MathParser = new MathParser(["x"]);
		var compObj:CompiledObject;
		compObj = procFun.doCompile(functionString);

		if (functionString == "") {
			return [];
		}
		if (compObj.errorStatus == 1) {
			ErrorBox.visible = true;
			ErrorBox.text = "Error in f(x). " + compObj.errorMes;
			shAxes.graphics.clear();
			return [];

		}
		var curx:Number;
		var cury:Number;
		var xstep = (nXmax - nXmin) / nPoints;
		var graphArray:Array = [];
		for (var i:Number = 0; i <= nPoints; i++) {
			curx = nXmin + xstep * i;
			cury = procFun.doEval(compObj.PolishArray, [curx]);
			graphArray[i] = [];
			graphArray[i] = [curx, cury];
		}
		return drawGraph(graphIndex, thickN, graphArray, colorN);
	}

	public function getStep() {
		var xstep = (nXmax - nXmin) / nPoints;
		return xstep;
	}

	public static function addCoordinatesToGraphArray(graphArray:Array, x:Number, y:Number):Array {
		graphArray.push([x, y])
		return graphArray;
	}

	public static function addFunctionToGraphArray(graphArray:Array, graphingBoard:GraphingBoardWrapper, functionString:String) {
		var curx:Number;
		var cury:Number;

		var xstep = (graphingBoard.nXmax - graphingBoard.nXmin) / graphingBoard.nPoints;

		var procFun:MathParser = new MathParser(["x"]);
		var compObj:CompiledObject;
		compObj = procFun.doCompile(functionString);

		if (functionString == "") {
			return [];
		}

		for (var i:Number = 0; i <= graphingBoard.nPoints; i++) {
			curx = graphingBoard.nXmin + xstep * i;
			cury = procFun.doEval(compObj.PolishArray, [curx]);
			graphArray[i] = [];
			graphArray[i] = [curx, cury];
		}
		return graphArray;
	}

	public function GraphingBoardWrapper(squareSize:Number) {
		super(squareSize);
		this.setCoordsBoxSizeAndPos(70, 35, 20, 1);
		this.nUserColor = 0xff0000;

	}

}
}
