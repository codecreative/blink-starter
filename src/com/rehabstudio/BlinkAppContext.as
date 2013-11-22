package com.rehabstudio 
{


	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author byron
	 */
	public class BlinkAppContext extends Context 
	{
		public function BlinkAppContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) 
		{
			super(contextView, autoStartup);
		}
		
		
		override public function startup() : void
		{
			
			// model
//			injector.mapSingleton(BlinkModel);
			
			// map startup command, only fires once
//			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, GetTimecodesCommand, ContextEvent, true);
			
			
			
			
			// App Events
//			commandMap.mapEvent(ApplicationEvent.TIMECODES_READY, CreateViewsCommand);
			
			
			// Views
//			mediatorMap.mapView(BlinkAppCoreView, BlinkAppCoreViewMediator);
			
			
//			contextView.addChild( new BlinkAppCoreView() );
			
			super.startup();
		}
	}
}
