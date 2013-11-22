package com.rehabstudio.examples 
{
	import com.rehabstudio.view.components.detector.webcam.BlinkAppWebCam;
	import com.rehabstudio.view.components.detector.BlinksDetector;
	import com.rehabstudio.Config;
	import net.hires.debug.Stats;


	import flash.display.Sprite;


	[SWF(width="640", height="480", backgroundColor=0xFFFFFF, frameRate="30")]
	[Frame(factoryClass="com.rehabstudio.examples.BlinkOnlyAppLoader")]
	public class BlinkOnlyTestApp extends Sprite 
	{
		private var detector : BlinksDetector;
		

		public function BlinkOnlyTestApp() 
		{
			Config.BLINK_DEBUG = true;
			
			detector = new BlinksDetector( onCameraStatusChange );
			addChild( detector );
			
			addChild( new Stats() ).x = 300;
			
			
		}
		
		private function onCameraStatusChange( code:String ): void
		{
			if (code == BlinkAppWebCam.UNMUTED)
			{
				detector.init();
			}
			
		}

		


	}
}
