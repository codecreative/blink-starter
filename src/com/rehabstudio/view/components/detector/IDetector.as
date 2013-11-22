package com.rehabstudio.view.components.detector
{
	import hislope.display.MetaBitmapData;
	import org.osflash.signals.ISignal;
	import flash.display.DisplayObject;
	/**
	 * @author byron
	 */
	public interface IDetector
	{
		
		function get onStatusChange(): ISignal;
		
		function set onDetection( onDetectionHandler:ISignal ): void;
		
		function init(): void;
		
		function asDO() : DisplayObject

		function dispose() : void;
		
		function get metaBitmapData(): MetaBitmapData
		
		function set alwaysUpdateDisplay( value:Boolean ): void;
		
		function pause(): void;
		
		function resume(): void;
		
		
	}
	
	
}
