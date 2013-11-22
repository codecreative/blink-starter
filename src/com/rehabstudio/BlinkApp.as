package com.rehabstudio 
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;

	import org.robotlegs.core.IContext;

	import flash.display.Sprite;


	[SWF(width="640", height="480", backgroundColor=0xFFFFFF, frameRate="30")]
	[Frame(factoryClass="com.rehabstudio.AppLoader")]
	public class BlinkApp extends Sprite 
	{
		
		private var _context : IContext;

		public function BlinkApp() 
		{
			TweenPlugin.activate( [AutoAlphaPlugin] );
			_context = new BlinkAppContext(this);
		}



	}
}
