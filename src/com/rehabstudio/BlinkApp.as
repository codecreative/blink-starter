package com.rehabstudio 
{
	import com.greensock.TweenLite;
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;
	import com.rehabstudio.view.components.detector.IDetector;
	import hislope.gui.Output;
	import flash.text.TextField;

	import com.rehabstudio.view.components.detector.BlinksDetector;
	import com.rehabstudio.view.components.detector.webcam.BlinkAppWebCam;

	import flash.display.Sprite;


	[SWF(width="640", height="480", backgroundColor=0xFFFFFF, frameRate="30")]
	[Frame(factoryClass="com.rehabstudio.AppLoader")]
	public class BlinkApp extends Sprite 
	{
		
		private var detector : IDetector;
		
		private var detectionSignal:ISignal;
		
		private var visualOutput:Output;
		
		private var textOutput:TextField;
		
		private var numBlinks:uint = 0;
		

		public function BlinkApp() 
		{
			
			// NOTE: For best performance, compile with the Apparat features turned on (TDSI, etc)
			// Can be done easily in FDT via project properties > Apparat.
			
			
			// set to false to not show the blink debugging output
			Config.BLINK_DEBUG = true;
			
			// using a signal that can be dispatched for anyone to listen
			detectionSignal = new Signal();
			
			// blink detector (a manual one exists as well for using spacebar)
			// in the virgin blinkwashing project, i use the DetectorManager class that can switch between blink/manual, but may be overkill for anything else
			// Constructing the BlinksDetector will also cause the camera popup, so may have to wait until a specific point in the app to create it, or modify the BlinksDetector class
			detector = new BlinksDetector( onCameraStatusChange );
			addChild( detector.asDO() );
			
			
			// text output window for demo purposes
			textOutput = new TextField();
			textOutput.textColor = 0x000000;
			textOutput.width = 400;
			textOutput.height = 300;
			textOutput.multiline = true;
			textOutput.border = true;
			textOutput.x = 370;
			textOutput.text = "Hello Blink Detection World";
			addChild( textOutput );
			
		
			
			
		}
		
		private function onCameraStatusChange( code:String ): void
		{
			if (code == BlinkAppWebCam.UNMUTED)
			{
				// NOTE: The sensitivity settings for the various components... ie how often to check where the face is, sensitivity, etc are
						// all located within the "init" function in BlinksDetector class. 
						// With the blink debugging on, you can tweak values and monitor performance and adjust the values as needed
						// There is also a Config.SENSITIVITY set up for the motion sensitivity. This can be adjusted in case
						// you need to pick up eyes darting (looking away) as a "blink" for example.
				detector.init();
				
				// the 'Output' can be used and parented anywhere during a 'calibration' process to give the user feedback
				// its visual feedback only, not necessary for the blink detection to work
				if(!visualOutput)
				{
					visualOutput = new Output( detector.metaBitmapData );
					visualOutput.x = textOutput.x;
					visualOutput.y = textOutput.y + 50;
					addChild( visualOutput );
				}
				
				// pass the signal into the detector
				detector.onDetection = detectionSignal;
				
				// handle the blink detection in this same class... could be happening in mediator, etc
				detectionSignal.add( onBlinkDetection );
				
				// resume turns the blink detection back on
				detector.resume();
			}
			
		}

		private function onBlinkDetection() : void 
		{
			numBlinks++;
			textOutput.text = "blink " + numBlinks + "\n" + textOutput.text;
			
			// pause stops the blink detector from doing the expensive calculations.
			// In blinkwashing project, we needed to only detect one blink, then time out for a while and resume checking
			// other projects may need to just pause it altogether and not resume until a 'retry' type of thing
			// Make sure to pause it when you don't need it or it will waste CPU
			detector.pause();
			
			// restart it after a second for demo purposes
			TweenLite.delayedCall( 1, detector.resume );
		}



	}
}
