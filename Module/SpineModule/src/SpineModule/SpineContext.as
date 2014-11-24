package SpineModule
{
	import SpineModule.view.SpineMediator;
	import SpineModule.view.SpineView;
	
	import flash.display.DisplayObjectContainer;
	
	import module.base.ModuleContext;
	
	import org.robotlegs.core.IInjector;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SpineContext extends ModuleContext
	{
		public function SpineContext(contextView:DisplayObjectContainer=null, parentInjector:IInjector=null)
		{
			super(contextView, parentInjector);
		}
		
		override protected function registMSCV():void
		{
			registView(SpineView,SpineMediator);
		}
	}
}