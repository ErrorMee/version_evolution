package module.managers
{
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.display.ContentDisplay;
	import com.gs_extends.MainLoaderManager;
	
	import config.resource.ResourceConfig;
	
	import structure.EnumVo;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ResourceManager
	{
		[Inject]
		public var i_ResourceConfig:ResourceConfig;
		
		public function ResourceManager()
		{
		}
		
		public function loadResource(loadtype:EnumVo,restype:String,name:String,queue:LoaderMax = null):LoaderItem
		{
			var url:String = i_ResourceConfig.getResPath(restype,name);
			var loaderItem:LoaderItem = MainLoaderManager.GetInstance().createLoader(loadtype,url,queue) as LoaderItem;
			return loaderItem;
		}
		
		public function getLoaderContent(restype:String,name:String):Object
		{
			var url:String = i_ResourceConfig.getResPath(restype,name);
			return LoaderMax.getContent(url);
		}
		
		public function getRawContent(restype:String,name:String):Object
		{
			var contentDisplay:ContentDisplay = getLoaderContent(restype,name) as ContentDisplay;
			if(contentDisplay)
			{
				return contentDisplay.rawContent;
			}else{
				return null;
			}
		}
	}
}