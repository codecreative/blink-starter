package com.rehabstudio.mother.virgin.blink.view.mediators
{
	import com.rehabstudio.mother.virgin.blink.model.BlinkModel;
	import com.rehabstudio.mother.virgin.blink.view.components.BlinkAppCoreView;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author byron
	 */
	public class BlinkAppCoreViewMediator extends Mediator
	{
		
		[Inject]
		public var model:BlinkModel;
		
		public function BlinkAppCoreViewMediator()
		{
		}
		
		
		override public function onRegister() : void
		{
			super.onRegister();
			view.model = model;
		}
		
		
		private function get view():BlinkAppCoreView
		{
			return viewComponent as BlinkAppCoreView;
		}
		
	}
}
