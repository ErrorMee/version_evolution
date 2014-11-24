package module.managers
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	import com.gs_extends.LoaderTypeEnum;
	import com.gs_extends.MainLoaderManager;
	
	import module.base.ModuleInfo;
	import module.interfaces.IModule;
	import module.interfaces.IModuleManager;
	
	import structure.HashMap;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleManager implements IModuleManager
	{
		private static const MODULE_NAME_SUFFIX:String = "Module";
		private static const MODULE_PATH:String = "module/";
		private static const MODULE_FILE_SUFFIX:String = ".swf";
		
		private var m_ModuleList:HashMap = new HashMap;
		
		private var m_ModuleReadyList:HashMap = new HashMap;
		
		public function ModuleManager()
		{
		}
		
		public function getModule(moduleType:String):IModule
		{
			return m_ModuleList.get(moduleType) as IModule;
		}
		
		public function openModule(info:ModuleInfo, callBack:Function=null):void
		{
			if(null == info) return;
			var moduleType:String = info.m_Name;
			var module:IModule = getModule(moduleType);
			
			if(module)
			{
				
			}else{
				var moduleName:String = moduleType + MODULE_NAME_SUFFIX;
				var moduleClassName:String = moduleName + "." + moduleName;
				var moduleUrl:String = MODULE_PATH + moduleName + MODULE_FILE_SUFFIX;
				
				var loaderItem:SWFLoader = MainLoaderManager.GetInstance().createLoader(LoaderTypeEnum.SWF_LOADER,moduleUrl) as SWFLoader;
				loaderItem.m_Data = moduleType;
				loaderItem.addEventListener(LoaderEvent.COMPLETE,onLoadModuleComplete);
				loaderItem.addEventListener(LoaderEvent.IO_ERROR,onLoadModuleError);
				loaderItem.load();
				
				m_ModuleReadyList.put(moduleType,{info:info,callBack:callBack});
			}
		}
		
		private function onLoadModuleError(e:LoaderEvent):void
		{
			var loaderItem:SWFLoader = e.currentTarget as SWFLoader;
			loaderItem.removeEventListener(LoaderEvent.COMPLETE,onLoadModuleComplete);
			loaderItem.removeEventListener(LoaderEvent.IO_ERROR,onLoadModuleError);
		}
		
		private function onLoadModuleComplete(e:LoaderEvent):void
		{
			var loaderItem:SWFLoader = e.currentTarget as SWFLoader;
			var moduleType:String = loaderItem.m_Data;
			var moduleReadyInfo:Object = m_ModuleReadyList.get(moduleType,true);
			loaderItem.removeEventListener(LoaderEvent.COMPLETE,onLoadModuleComplete);
			loaderItem.removeEventListener(LoaderEvent.IO_ERROR,onLoadModuleError);
			var module:IModule = getModule(moduleType);
			if(module) 
			{
				throw(new Error("重复模块加载：" + moduleType));
				return;
			}
			var moduleName:String = moduleType + MODULE_NAME_SUFFIX;
			var moduleClassName:String = moduleName + "." + moduleName;
			
			var info:ModuleInfo = moduleReadyInfo.info;
			var callBack:Function = moduleReadyInfo.callBack;
			linkModule(info,moduleClassName,loaderItem);
			
			module = getModule(moduleType);
			if(module)
			{
				if(callBack != null) 
				{
					callBack(module);
					callBack = null;
				}
			}
		}
		
		private function linkModule(info:ModuleInfo,className:String,loaderItem:SWFLoader):void
		{
			if(null == info) return;
			if(getModule(info.m_Name)) return;
			var ModuleClass:Class = loaderItem.getClass(className);
			if(ModuleClass)
			{
				var moduleInstanse:IModule = new ModuleClass() as IModule;
				moduleInstanse.setName(info.m_Name);
				m_ModuleList.put(info.m_Name,moduleInstanse);
			}
		}
		
		public function closeModule(info:ModuleInfo,callBack:Function = null):void
		{
			var moduleInstance:IModule = getModule(info.m_Name);
			if(!moduleInstance) return;
			moduleInstance.close();
			
			if(callBack != null) 
			{
				callBack(moduleInstance);
				callBack = null;
			}
		}
		
		public function destroyModule(info:ModuleInfo,callBack:Function=null):void
		{
			var moduleInstance:IModule = getModule(info.m_Name);
			if(!moduleInstance) return;
			moduleInstance.dispose();
			m_ModuleList.put(info.m_Name,null);
			
			var moduleType:String = info.m_Name;
			var moduleName:String = moduleType + MODULE_NAME_SUFFIX;
			var moduleClassName:String = moduleName + "." + moduleName;
			var moduleUrl:String = MODULE_PATH + moduleName + MODULE_FILE_SUFFIX;
			MainLoaderManager.GetInstance().unLoadSwf(moduleUrl);
		}
	}
}