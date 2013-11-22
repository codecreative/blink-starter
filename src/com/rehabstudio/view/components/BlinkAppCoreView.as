package com.rehabstudio.view.components {
	import com.rehabstudio.view.components.intro.IntroScreen;
	import com.rehabstudio.view.components.detector.DetectorManager;
	import com.rehabstudio.Config;
	import com.google.analytics.GATracker;
	import com.bit101.components.PushButton;
	import com.greensock.easing.Linear;
	import net.hires.debug.Stats;

	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Sound;

	/**
	 * @author byron
	 */
	public class BlinkAppCoreView extends Sprite
	{
		private var _detector:DetectorManager;
		private var _intro:IntroScreen;
		private var w : Number;
		private var h : Number;
		
		private var blinkCount:Number = 0;
		
		
		
		public function BlinkAppCoreView()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );

		}
		
		private function onAddedToStage(event : Event) : void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			this.w = Math.min( stage.stageWidth, Config.MAX_WIDTH );
			this.h = stage.stageHeight;
			
//			_model.tracker = new GATracker(this.stage, Config.GA_ID, "AS3", false);
			
			init();
			
			
		}
		

		private function init() : void
		{

			
			_intro = new IntroScreen();
			_intro.onShowWebcam.add( onShowWebcam );
			_intro.retryCalibration.add( getUserCam );
			_intro.onComplete.addOnce( onIntroComplete );
			_intro.useManualSwitching.add( manualDetection );
			
			addChild( _intro );
			
			_detector = new DetectorManager();
			
			_detector.onDetectionReady.add( onDetectionReady );
			addChild( _detector );
			
			
			
			
			
		}


		private function getUserCam() : void 
		{
			_detector.initDetector();
			
		}


		private function manualDetection() : void
		{
			useManualDetection();
			
			_intro.useManualSwitching.remove( manualDetection );
		}

		
		private function onShowWebcam() : void
		{
			
			if ( Camera.names.length < 1 )
			{
				showWebcamWarning();
			}
			else
			{
				_detector.onNoWebcam.addOnce( showWebcamWarning );
				_detector.init( !Config.BLINK );
			}

			
		}

		private function onDetectionReady() : void
		{
			TweenLite.delayedCall(1, _intro.webcamAccepted, [_detector.metaBitmapData]);
			
			_intro.onBlinkReady.add( onIntroBlinkReady );
			
		}

		private function onIntroBlinkReady() : void
		{
			TweenLite.delayedCall(0.25, _detector.onDetection.addOnce, [onIntroBlinkDetection] );
			_detector.resume();
			
			_intro.startBlinkTimerCheck();

		}

		
//		private function startVideos():void
//		{
//			
//			_intro.onBlinkReady.remove( onIntroBlinkReady );
//			_intro.visible = false;
//			removeChild( _intro );
//			
//			
//			// now that webcam display is over, make sure the detector isn't rendering inbetween blinks
//			_detector.alwaysUpdateDisplay = false;
//			_detector.pause();
//			
//			_detector.onNoWebcam.remove( showWebcamWarning );
//		}



		private function onVideosReadyForChange() : void 
		{
			_detector.resume();
			
			// slight delay to avoid picking up a false blink due to the old state of the detector
			TweenLite.delayedCall(0.25, listenForDetection);
			
		}
		
		private function listenForDetection(): void
		{
			_detector.onDetection.addOnce( onBlinkDetection );
		}

		private function onFinish() : void
		{	
//			_outro.show();

			_detector.pause();

		}



		private function onIntroBlinkDetection() : void
		{
			_intro.blink();
//			sound.play();
			
			if( _intro.numBlinks >= 2 ) _detector.pause();
		}
		
		private function onBlinkDetection() : void
		{
			_detector.onDetection.removeAll();
			_detector.pause();
//			sound.play();
			
			//increment to count how many blinks were caught - excludes the intro detection
			blinkCount++;
			
			
		}
		
		private function showWebcamWarning(): void
		{
			
		}

		private function useManualDetection(e:Event = null) : void 
		{
			//USING MANUAL SPACEBAR SWITCHING
			_detector.init(true);
		}

		
		
	}
}
