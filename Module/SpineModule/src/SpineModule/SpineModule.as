package SpineModule
{
	import SpineModule.view.SpineView;
	
	import flash.system.ApplicationDomain;
	
	import module.base.WindowModule;
	import module.managers.LayerEnum;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SpineModule extends WindowModule
	{
		public function SpineModule()
		{
			super();
		}
		
		override protected function onStartUp():void
		{
			initModule(SpineView,SpineContext,ApplicationDomain.currentDomain);
		}
	}
}