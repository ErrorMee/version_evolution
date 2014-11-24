package LoginModule 
{
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	
	import module.base.ModuleContext;
	
	import org.robotlegs.core.IInjector;
	
	
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LoginContext extends ModuleContext
	{
		public function LoginContext(contextView:DisplayObjectContainer=null, parentInjector:IInjector=null, applicationDomain:ApplicationDomain = null)
		{
			super(contextView, parentInjector, applicationDomain);
		}
		
		override protected function registMSCV():void
		{
			registService(LoginService);
			registView(LoginView,LoginMediator);
		}
	}
}