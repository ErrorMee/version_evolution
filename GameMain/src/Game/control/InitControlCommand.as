package Game.control
{
	import com.gs_extends.MainLoaderManager;
	
	import config.module.ModuleConfig;
	import config.module.ModuleConfigInfo;
	
	import module.base.ModuleInfo;
	import module.cmd.ModuleCommand;
	import module.interfaces.IModule;
	import module.managers.ModuleManager;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitControlCommand extends ModuleCommand
	{
		[Inject]
		public var i_ModuleManager:ModuleManager;
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		public function InitControlCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var moduleInfo:ModuleInfo = new ModuleInfo();
			var moduleConfigInfo:ModuleConfigInfo = i_ModuleConfig.getConfigInfo(10000) as ModuleConfigInfo;
			if(moduleConfigInfo)
			{
				moduleInfo.m_Name = moduleConfigInfo.dev_name;
				i_ModuleManager.openModule(moduleInfo,onOpenControlComplete);
			}
		}
		
		private function onOpenControlComplete(moduleInstance:IModule):void
		{
			injector.injectInto(moduleInstance);
			moduleInstance.startUp(MainLoaderManager.MAIN_INJECTOR);
		}
	}
}