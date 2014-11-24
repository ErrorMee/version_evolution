package module.base
{
	import com.gs_extends.MainLoaderManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import module.interfaces.IModuleContext;
	
	import org.robotlegs.base.CommandMap;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.base.ViewMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Context;
	
	import service.BaseService;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleContext extends Context implements IModuleContext
	{
		public function ModuleContext(contextView:DisplayObjectContainer=null, parentInjector:IInjector=null, domain:ApplicationDomain = null)
		{
			if(parentInjector)
			{
				//创建子域注射器
				var applicationdomain:ApplicationDomain = domain || ApplicationDomain.currentDomain;
				injector = parentInjector.createChild(applicationdomain);
				mediatorMap = new MediatorMap(contextView, injector, reflector);
				commandMap = new CommandMap(eventDispatcher, injector, reflector);
				viewMap = new ViewMap(contextView, injector);
			}
			
			super(contextView, true);
		}
		
		override public function startup():void
		{
			registMSCV();
			super.startup();
		}
		
		public function clear():void
		{
		}
		
		public function dispose():void
		{
			clear();
			if(_injector)
			{
				_injector.applicationDomain = null;
				_injector = null;
			}
			_reflector = null;
			
			if(_mediatorMap)
			{
				_mediatorMap.removeMediatorByView(_contextView);
				_mediatorMap = null;
			}
			_contextView = null;
			_eventDispatcher = null;
			if(_commandMap)
			{
				_commandMap.unmapEvents();
				_commandMap = null;
			}
			_viewMap = null;
		}
		
		/**
		 * 统一注册 Model Service Commond View 
		 */
		protected function registMSCV():void {};
		protected function registService(serviceClass:Class):void
		{
			var serviceInstance:BaseService = new serviceClass;
			injector.injectInto(serviceInstance);
			serviceInstance.startup();
			injector.mapValue(serviceClass,serviceInstance);
		}
		protected function registView(viewClass:Class, mediatorClass:Class):void
		{
			mediatorMap.mapView(viewClass,mediatorClass);
		}
	}
}