package com.rehabstudio.view.components.intro {
	import com.greensock.TweenLite;
	import hislope.display.MetaBitmapData;
	import hislope.gui.Output;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Sprite;
	import flash.events.Event;

	

	/**
	 * @author byron
	 */
	public class IntroScreen extends Sprite
	{

		public var onStart:ISignal;
		public var onShowWebcam:ISignal;
		public var onBlinkReady:ISignal;
		public var onComplete:ISignal;
		public var useManualSwitching:ISignal;
		public var retryCalibration:ISignal;
		
		
		private var _blinks:uint = 0;
		
		private var _output:Output;
		
		
		
		
		public function IntroScreen()
		{
			onStart = new Signal();
			onShowWebcam = new Signal();
			onBlinkReady = new Signal();
			onComplete = new Signal();
			
			useManualSwitching = new Signal();
			retryCalibration = new Signal();
			
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );	
			
		}
		
		
		
		public function start(): void
		{
			// do intro animation, then show webcam alert.
			// just pretending for now
			TweenLite.delayedCall( 2, showWebcamPopup );
		}



		private function showWebcamPopup() : void 
		{
			onShowWebcam.dispatch();
		}
		
		
		private function onFail0Click(e:Event) : void 
		{
			retryCalibration.dispatch();
			
		}

		private function onFail1Click(e:Event) : void 
		{
			useManualSwitching.dispatch();
		}


		private function onRemovedFromStage(event : Event) : void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			if (_output)
			{
				_output = null;
			}

		}
		
		public function webcamAccepted( metaBitmapData:MetaBitmapData ): void
		{
			

			if (metaBitmapData)
			{
				_output = new Output(metaBitmapData, "output", true, false);
				
				// add webcam 
				addChild(_output);
			}

		}
		
		

		private function onSpacebar(e:Event) : void 
		{
			useManualSwitching.dispatch();
		}

		private function onCompleteHandler(event : Event) : void
		{
			onComplete.dispatch();
			
		}



		private function onBlinkReadyHandler(event : Event) : void
		{
			onBlinkReady.dispatch();
		}
		
		public function blink(): void
		{
			
			_blinks++;
					
			if (_blinks == 1)
			{
				
			}
			else if (_blinks == 2)
			{

				
				
				
			}
		}



		
		public function get numBlinks(): uint
		{
			 return _blinks;
		}
		
	}
}
