package LoginModule 
{
	
	import flash.system.ApplicationDomain;
	
	import module.base.WindowModule;
	import module.managers.LayerEnum;
	import module.managers.LayerManager;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LoginModule extends WindowModule
	{
		public function LoginModule()
		{
			super();
		}
		
		override protected function onStartUp():void
		{
			initModule(LoginView,LoginContext,ApplicationDomain.currentDomain);
		}
	}
}