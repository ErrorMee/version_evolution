package ControlModule.view
{
	import com.gs_extends.MainLoaderManager;
	
	import config.module.ModuleConfig;
	
	import module.base.ModuleInfo;
	import module.event.ModuleEvent;
	import module.interfaces.IModule;
	import module.managers.ModuleManager;
	import module.mediator.ModuleMediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModulesMediator extends ModuleMediator
	{
		[Inject]
		public var i_ModuleManager:ModuleManager;
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		public function ModulesMediator()
		{
			super();
		}
		
		override protected function initEvent():void
		{
			addModuleListener(ModuleEvent.ME_ENTER.m_Name,onModuleEnter);
			addModuleListener(ModuleEvent.ME_CLOSE.m_Name,onModuleClose);
			addModuleListener(ModuleEvent.ME_DISPOSE.m_Name,onModuleDispose);
		}
		
		override protected function initRequest():void
		{
			openModule(i_ModuleConfig.getModuleDevName(10001));
		}
		
		private function onModuleEnter(e:ModuleEvent):void
		{
			var moduleInfo:ModuleInfo = e.getModuleInfo();
			if(moduleInfo == null) return ;
			i_ModuleManager.openModule(moduleInfo,onOpenComplete);
		}
		
		private function onOpenComplete(moduleInstance:IModule):void
		{// as 比 is 效率高
			log("open " + moduleInstance.getName(),i_ModuleConfig.getModuleDevName(10000));
			MainLoaderManager.MAIN_INJECTOR.injectInto(moduleInstance);
			moduleInstance.startUp(MainLoaderManager.MAIN_INJECTOR);
		}
		
		private function onModuleClose(e:ModuleEvent):void
		{
			var moduleInfo:ModuleInfo = e.getModuleInfo();
			if(moduleInfo == null) return ;
			i_ModuleManager.closeModule(moduleInfo,onCloseComplete);
		}
		
		private function onCloseComplete(moduleInstance:IModule):void
		{
			log("close " + moduleInstance.getName(),i_ModuleConfig.getModuleDevName(10000));
		}
		
		private function onModuleDispose(e:ModuleEvent):void
		{
			var moduleInfo:ModuleInfo = e.getModuleInfo();
			if(moduleInfo == null) return ;
			i_ModuleManager.destroyModule(moduleInfo);
			log("dispose " + moduleInfo.m_Name,i_ModuleConfig.getModuleDevName(10000));
		}
	}
}