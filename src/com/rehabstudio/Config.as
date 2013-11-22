package com.rehabstudio
{
	/**
	 * @author byron
	 */
	public class Config
	{
		// lazy
		

		// blink mode. originally set to false for forcing a manual "blink" via spacebar
		public static var BLINK : Boolean = true;

		// true shows the blink debug panel
		public static var BLINK_DEBUG : Boolean = false;
		
		// motion sensitivity setting. higher is more sensitive
		public static var SENSITIVITY : Number = 65.000;
		
		// eye blob detection sizes
		public static var MIN_BLOB_SIZE : Number = 4.000;
		
		// if max size
		public static const MAX_WIDTH : Number = 960;
		
		
	}
}
