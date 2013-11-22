package com.rehabstudio.view.components.detector
{
	import hislope.display.MetaBitmapData;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import com.greensock.TweenLite;
	import flash.display.Sprite;


	import org.osflash.signals.ISignal;

	import flash.display.DisplayObject;

	/**
	 * @author byron
	 */
	public class ManualDetector extends Sprite implements IDetector
	{
		
		private var _onDetectionHandler:ISignal;
		
		private var isBlinkActive:Boolean = false;
		
		public function ManualDetector()
		{
		}

		public function init() : void
		{
			
			if (!stage) addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
			else onAddedToStage(null);
			
			
			isBlinkActive = true;
		}

		private function onAddedToStage(event : Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
		}

		private function reportKeyDown(event : KeyboardEvent) : void
		{
			 trace("Key Pressed: " + String.fromCharCode(event.charCode) +         " (character code: " + event.charCode + ")");
			 
			 if (!isBlinkActive) return;
			 
			 if (event.charCode == Keyboard.SPACE)
			 {
				onChange();
				
			 }
		}
		


		public function asDO() : DisplayObject
		{
			return this as DisplayObject;
		}

		public function get onStatusChange() : ISignal
		{
			// TODO: Auto-generated method stub
			return null;
		}

		public function dispose() : void
		{
			// TODO: Auto-generated method stub
			_onDetectionHandler = null;
		}

		public function set onDetection(onDetectionHandler : ISignal) : void
		{
			_onDetectionHandler = onDetectionHandler;
		}
		
		
		private function onChange() : void
		{
			isBlinkActive = false;
			
			// reset after time
			TweenLite.delayedCall(1, resetBlinkActive );
			
			if (_onDetectionHandler) _onDetectionHandler.dispatch();
		}

		private function resetBlinkActive(): void
		{
			isBlinkActive = true;
		}

		public function get metaBitmapData() : MetaBitmapData
		{
			return null;
		}

		public function set alwaysUpdateDisplay(value : Boolean) : void {
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
