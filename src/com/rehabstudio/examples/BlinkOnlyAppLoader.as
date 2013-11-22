package com.rehabstudio.examples
{


	import com.rehabstudio.Config;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;

	public class BlinkOnlyAppLoader extends MovieClip {
		private var _applicationClass : String = "com.rehabstudio.examples.BlinkOnlyTestApp";

		// private var _loaderAnim : AppLoaderAnim;
		// private var _loaderText : LoadingText;
		public function BlinkOnlyAppLoader() {
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			
			
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame, false, 0, true);
		}

		private function init() : void {
			var Clazz : Class = getDefinitionByName(_applicationClass) as Class;

			if (Clazz) {
				var app : Sprite = addChild(new Clazz()) as Sprite;
			}
		}

		private function removeLoaderAnim(e : Event = null) : void {
			// TODO assuming there will be a loader animation
			nextFrame();
			init();
		}

		private function handleEnterFrame(e : Event) : void {


			trace("preloading: " + framesLoaded + " , " + totalFrames);
			
			if (framesLoaded == totalFrames) {
				removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
				removeLoaderAnim();

			}
		}
	}
}
