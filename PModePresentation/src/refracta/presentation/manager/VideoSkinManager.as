/**
 * 개발자 : refracta
 * 날짜   : 2014-09-06 오전 9:08
 */
package refracta.presentation.manager {
import com.greensock.loading.SWFLoader;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

import refracta.presentation.pconst.PresentationConst;

public class VideoSkinManager {
	private var _viewClip:MovieClip;
	private var dataLoader:URLLoader;
	private var testSwfLoader:Loader;
	private var testLoaderContextData:LoaderContext;
	private var _isLoaded:Boolean = false;



	public function set viewClip(value:MovieClip):void {
		_viewClip = value;
	}

	public function get isLoaded():Boolean {
		return _isLoaded;
	}

	public function set isLoaded(value:Boolean):void {
		_isLoaded = value;
	}

	public function get viewClip():MovieClip {
		return _viewClip;
	}


	public function VideoSkinManager() {
		this._viewClip = new MovieClip();
		this.dataLoader = new URLLoader();
		this.dataLoader.dataFormat = URLLoaderDataFormat.BINARY;
		this.dataLoader.addEventListener(Event.COMPLETE, dataLoadComplete);
		this.dataLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		this.dataLoader.addEventListener(IOErrorEvent.IO_ERROR, useCacheData);

		this.testLoaderContextData = new LoaderContext();
		this.testLoaderContextData.allowLoadBytesCodeExecution = true;

		this.testSwfLoader = new Loader();
		this.testSwfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, useCacheData);
		this.testSwfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		this.testSwfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, passSwfTest);
	}

	public function loadStart() {
		if (!PresentationConst.VIDEO_SKIN_FILE_CACHE_LOCATION.exists) {
			trace("Load From Server (VIDEO SKIN)");
			this.dataLoader.load(PresentationConst.VIDEO_SKIN_FILE_URL);
		} else {
			trace("Load From File (VIDEO SKIN)");
			this.dataLoader.load(new URLRequest(PresentationConst.VIDEO_SKIN_FILE_CACHE_LOCATION.url));
		}
	}

	private function progressHandler(event:ProgressEvent):void {
		var percentLoaded:int = event.target.bytesLoaded / event.target.bytesTotal * 100;
		var callName:String = "VideoSkin";
		trace("[" + callName + "] Current Loading : " + percentLoaded);
	}

	private var loadSwfArray:ByteArray;

	private function dataLoadComplete(event:Event):void {
		this.loadSwfArray = ByteArray(this.dataLoader.data);
		this.testSwfLoader.loadBytes(loadSwfArray, this.testLoaderContextData);
	}

	private function useCacheData(event:*) {
		trace("Use Cache Data");
		if (!PresentationConst.VIDEO_SKIN_FILE_CACHE_LOCATION.exists) {
			trace("No Cache");
			return;
		}
		this._isLoaded = true;
	}

	private function passSwfTest(event:Event) {
		saveSwfBytes(event);
		//뷰에 넣기
		this._isLoaded = true;
	}



	private function saveSwfBytes(event:*) {
		testSwfLoader.unload();
		var fileStream:FileStream = new FileStream();
		fileStream.addEventListener(IOErrorEvent.IO_ERROR, useCacheData);
		fileStream.open(PresentationConst.VIDEO_SKIN_FILE_CACHE_LOCATION, FileMode.WRITE);
		fileStream.writeBytes(loadSwfArray);
		fileStream.close();
	}


}
}
