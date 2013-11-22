package com.rehabstudio.view.components.detector.webcam {
	import hislope.filters.inputs.WebCam;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.events.StatusEvent;

	/**
	 * @author byron
	 */
	public class BlinkAppWebCam extends WebCam
	{
		public static const MUTED:String = "Camera.Muted";
		public static const UNMUTED:String = "Camera.Unmuted";
		
		
		public var statusChange:ISignal;
		
		public function BlinkAppWebCam(OVERRIDE : Object = null)
		{
			statusChange = new Signal();
			
			super(OVERRIDE);
		}
		
		
		override protected function onStatusChange(event : StatusEvent) : void
		{
			trace("******** blink app camera status change: " + event.code);
			statusChange.dispatch(event.code);
			// super.onStatusChange(event);
		}


	}
}
