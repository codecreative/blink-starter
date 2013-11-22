package com.rehabstudio.view.components.detector {
	import hislope.core.FilterChain;
	import hislope.display.MetaBitmapData;
	import hislope.events.HiSlopeEvent;
	import hislope.filters.FilterBase;
	import hislope.filters.detectors.BlinkDetector;
	import hislope.filters.detectors.EyesArea;
	import hislope.filters.detectors.QuickFaceDetector;
	import hislope.filters.motion.MotionCapture;

	import com.rehabstudio.Config;
	import com.rehabstudio.view.components.detector.webcam.BlinkAppWebCam;

	import org.osflash.signals.ISignal;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author byron
	 */
	public class BlinksDetector extends Sprite implements IDetector
	{
		public var statusChange:ISignal;
		
		private var DEBUG:Boolean = false;
		
		// time between when blinks can occur (in milliseconds)
		public static var MIN_BLINK_RESET_TIME:uint = 2000;
		
		
		private var processedBmpData:MetaBitmapData;
		private var filterChain:FilterChain;
		
		private var inputWC:BlinkAppWebCam;
		
		private var isBlinkActive:Boolean;
		
		private var statusChangeCallback : Function;
		private var _onDetectionHandler : ISignal;
		
		private var _isAlwaysUpdateDisplay : Boolean = true;
		
		
		public function BlinksDetector( statusChangeCallback:Function = null )
		{
			this.statusChangeCallback = statusChangeCallback;
			
			// turn on blink debug remotely
			if (Config.BLINK_DEBUG) DEBUG = true;
			
			getWebcam();
		}

		public function getWebcam() : void
		{
			
			inputWC = new BlinkAppWebCam();
			inputWC.statusChange.add( statusChangeCallback );
			inputWC.restartCamera();
		}
		
		public function init(): void
		{
			const SCALE:Number = 1.6;

			filterChain = new FilterChain("Blink Test", 320 * SCALE, 240 * SCALE, DEBUG);
			addChild(filterChain);

			processedBmpData = new MetaBitmapData(FilterBase.WIDTH, FilterBase.HEIGHT, false, 0);

			
			filterChain.addFilter(inputWC, true);
			inputWC.addEventListener(HiSlopeEvent.INPUT_RENDERED, render, false, 0, true);
			filterChain.addFilter(new MotionCapture( {sensitivity: Config.SENSITIVITY, blurAmount: 10.000, blurQuality: 1.000, timeout: 0.250, lockPosition: false} ));
			filterChain.addFilter(new QuickFaceDetector( {interval: 2.000, scaleFactor: 0.200} ));
//			filterChain.addFilter(new EyeFinder());
			filterChain.addFilter(new EyesArea());
			filterChain.addFilter(new BlinkDetector( {maxBlobs: 2.000, blobColor: 0xFFFFFF, minBlobWidth: Config.MIN_BLOB_SIZE, minBlobHeight: Config.MIN_BLOB_SIZE, maxBlobWidth: 106.000, maxBlobHeight: 103.000} ));
		
			
		}
		
		
		
		private function render(event:Event):void
		{
			if (isBlinkActive)
			{
				filterChain.process(processedBmpData);
				
				
				if (processedBmpData.eyesBlink)
				{
					
					if (_onDetectionHandler) _onDetectionHandler.dispatch();
					
				}
				
			}
			else
			{
				// still may need to update the camera display ( for intro )
				if (_isAlwaysUpdateDisplay) filterChain.process(processedBmpData);
			}
			
		}
		

		public function asDO() : DisplayObject
		{
			return this as DisplayObject;
		}

		public function get onStatusChange() : ISignal
		{
			return null;
		}

		public function dispose() : void
		{
			_onDetectionHandler = null;
		}

		public function set onDetection(onDetectionHandler : ISignal) : void
		{
			_onDetectionHandler = onDetectionHandler;
		}

		public function get metaBitmapData() : MetaBitmapData
		{
			return processedBmpData;
		}

		public function set alwaysUpdateDisplay(value : Boolean) : void 
		{
			_isAlwaysUpdateDisplay = value;
		}

		public function pause() : void 
		{
			isBlinkActive = false;
		}

		public function resume() : void 
		{
			isBlinkActive = true;
		}
		
		
	}
}
