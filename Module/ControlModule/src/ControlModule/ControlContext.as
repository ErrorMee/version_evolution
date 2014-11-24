package ControlModule
{
	import ControlModule.view.ControlMediator;
	import ControlModule.view.ControlView;
	
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	
	import module.base.ModuleContext;
	
	import org.robotlegs.core.IInjector;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ControlContext extends ModuleContext
	{
		public function ControlContext(contextView:DisplayObjectContainer=null, parentInjector:IInjector=null, applicationDomain:ApplicationDomain=null)
		{
			super(contextView, parentInjector, applicationDomain);
		}
		
		override protected function registMSCV():void
		{
			registView(ControlView,ControlMediator);
		}
	}
}