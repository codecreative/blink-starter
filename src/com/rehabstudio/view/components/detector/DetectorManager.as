package com.rehabstudio.view.components.detector {
	import hislope.display.MetaBitmapData;

	import com.rehabstudio.view.components.detector.webcam.BlinkAppWebCam;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Sprite;

	/**
	 * @author byron
	 */
	public class DetectorManager extends Sprite
	{
		public var onDetection:ISignal;
		public var onDetectionReady:ISignal;
		public var onNoWebcam:ISignal;
		
		private var _detector:IDetector;
		
		public function DetectorManager()
		{
			onDetection = new Signal();
			onDetectionReady = new Signal();
			onNoWebcam = new Signal();
			
			
		}
		
		public function init( forceManual:Boolean = false ): void
		{
			if (forceManual)
			{
				attemptManualDetector();
			}
			else
			{
				attemptBlinkDetector();
			}
		}

		private function attemptBlinkDetector() : void
		{
			clearDetector();
			
			_detector = new BlinksDetector( onCameraStatusChange );
			_detector.onDetection = onDetection;
			addChild( _detector.asDO() );
		}

		private function attemptManualDetector() : void
		{
			clearDetector();
			
			_detector = new ManualDetector();
			_detector.onDetection = onDetection;
			addChild( _detector.asDO() );
			
			_detector.init();
			
			onDetectionReady.dispatch();
			
		}

		private function clearDetector() : void
		{
			if (_detector)
			{
				if ( contains( _detector.asDO() ) )
				{
					removeChild( _detector.asDO() );
				}
//				_detector.dispose();
			}
		}

		public function initDetector():void
		{
			_detector.init();
		}
		
		private function onCameraStatusChange( code:String ): void
		{
			
			if (code == BlinkAppWebCam.UNMUTED)
			{
				_detector.init();
				onDetectionReady.dispatch();
			}
			else if ( code == BlinkAppWebCam.MUTED )
			{
				onNoWebcam.dispatch();					
			}
			
			
		}

		public function get metaBitmapData() : MetaBitmapData
		{
			return _detector.metaBitmapData;
		}

		public function set alwaysUpdateDisplay( value : Boolean) : void {
			_detector.alwaysUpdateDisplay = value;
		}

		public function resume() : void 
		{
			if (_detector) _detector.resume();
		}
		
		public function pause() : void 
		{
			if (_detector) _detector.pause();
		}
		
		
		
	}
}
