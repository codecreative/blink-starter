package com.rehabstudio.log {
	import flash.external.ExternalInterface;
	/**
	 * @author byron
	 */
	public class Logger 
	{
		
		
		public static function log( str:String ): void
		{
			
			trace( str );
			
//			if (ExternalInterface.available)
//			{
//				ExternalInterface.call("console.log", str);
//			}
		}
	}
}
