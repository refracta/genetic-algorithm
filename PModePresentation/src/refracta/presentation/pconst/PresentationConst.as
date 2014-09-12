/**
 * 개발자 : refracta
 * 날짜   : 2014-09-04 오전 6:06
 */
package refracta.presentation.pconst {
import flash.filesystem.File;
import flash.net.URLRequest;

public class PresentationConst {
	public static var DEFAULT_URL:String = "http://null.abstr.net/ga/ppt/";

	public static const LOGO_FILE_NAME:String = "logo.swf";
	public static var LOGO_URL:URLRequest = new URLRequest(DEFAULT_URL + "resources/logo.swf" + "?time=" + Number(new Date().getTime()));
	public static var LOGO_CACHE_LOCATION:File = new File(File.applicationDirectory.nativePath + "\\resources\\" + LOGO_FILE_NAME);

	public static const GRAPH_SIMULATOR_FILE_NAME:String = "graph_simulator.swf";
	public static var GRAPH_SIMULATOR_URL:URLRequest = new URLRequest(DEFAULT_URL + "resources/graph_simulator.swf" + "?time=" + Number(new Date().getTime()));
	public static var GRAPH_SIMULATOR_CACHE_LOCATION:File = new File(File.applicationDirectory.nativePath + "\\resources\\" + GRAPH_SIMULATOR_FILE_NAME);

	public static const PHYSICAL_SIMULATOR_FILE_NAME:String = "physical_simulator.swf";
	public static var PHYSICAL_SIMULATOR_URL:URLRequest = new URLRequest(DEFAULT_URL + "resources/physical_simulator.swf" + "?time=" + Number(new Date().getTime()));
	public static var PHYSICAL_SIMULATOR_CACHE_LOCATION:File = new File(File.applicationDirectory.nativePath + "\\resources\\" + PHYSICAL_SIMULATOR_FILE_NAME);

	public static const VIDEO_SKIN_FILE_NAME:String = "MinimaFlatCustomColorPlayBackSeekMute.swf";
	public static var VIDEO_SKIN_FILE_URL:URLRequest = new URLRequest(DEFAULT_URL + "resources/MinimaFlatCustomColorPlayBackSeekMute.swf" + "?time=" + Number(new Date().getTime()));
	public static var VIDEO_SKIN_FILE_CACHE_LOCATION:File = new File(File.applicationDirectory.nativePath + "\\resources\\" + VIDEO_SKIN_FILE_NAME);


	public static const PRESENTATION_WIDTH:Number = 1366;
	public static const PRESENTATION_HEIGHT:Number = 768;


	public static function setURL(url:String) {
		trace("URL CHANGED : "+DEFAULT_URL + " → "+url);
		DEFAULT_URL = url;
		LOGO_URL = new URLRequest(DEFAULT_URL + "logo.swf" + "?time=" + Number(new Date().getTime()));
		LOGO_CACHE_LOCATION = new File(File.applicationDirectory.nativePath + "\\resources\\" + LOGO_FILE_NAME);

		GRAPH_SIMULATOR_URL = new URLRequest(DEFAULT_URL + "graph_simulator.swf" + "?time=" + Number(new Date().getTime()));
		GRAPH_SIMULATOR_CACHE_LOCATION = new File(File.applicationDirectory.nativePath + "\\resources\\" + GRAPH_SIMULATOR_FILE_NAME);


		PHYSICAL_SIMULATOR_URL = new URLRequest(DEFAULT_URL + "physical_simulator.swf" + "?time=" + Number(new Date().getTime()));
		PHYSICAL_SIMULATOR_CACHE_LOCATION = new File(File.applicationDirectory.nativePath + "\\resources\\" + PHYSICAL_SIMULATOR_FILE_NAME);


		VIDEO_SKIN_FILE_URL = new URLRequest(DEFAULT_URL + "MinimaFlatCustomColorPlayBackSeekMute.swf" + "?time=" + Number(new Date().getTime()));
		VIDEO_SKIN_FILE_CACHE_LOCATION = new File(File.applicationDirectory.nativePath + "\\resources\\" + VIDEO_SKIN_FILE_NAME);
	}


}
}
