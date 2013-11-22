package com.rehabstudio
{
	import flash.system.Security;
	import flash.utils.getTimer;
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	public class AppLoader extends MovieClip {
		
		private static const SECURITY_DOMAIN:String = "http://www.youtube.com";
		
		
		private var _applicationClass : String = "com.rehabstudio.BlinkApp";
		
		private var startTime:Number;
		private var endTime:Number;

		// private var _loaderAnim : AppLoaderAnim;
		// private var _loaderText : LoadingText;
		public function AppLoader() {
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			
			Security.allowDomain("s.ytimg.com");
			Security.allowDomain(SECURITY_DOMAIN);
			
			
			
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame, false, 0, true);
		}

		private function init() : void {
			var Clazz : Class = getDefinitionByName(_applicationClass) as Class;

			if (Clazz) {
				var app : Sprite = addChild(new Clazz()) as Sprite;
			}
		}

		private function removeLoaderAnim(e : Event = null) : void 
		{
			
			
			// TODO assuming there will be a loader animation
			nextFrame();
			init();
		}

		private function handleEnterFrame(e : Event) : void 
		{
			
			
			if (framesLoaded == totalFrames) {
				removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
				removeLoaderAnim();
				
				endTime = getTimer();
				
			}
		}
	}
}
