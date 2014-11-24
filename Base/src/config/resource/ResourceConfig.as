package config.resource
{
	import config.base.BaseConfig;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ResourceConfig extends BaseConfig
	{
		private static const RES_PATH:String = "resource/";
		
		public function ResourceConfig()
		{
			super();
		}
		
		public function getResPath(type:String,name:String):String
		{
			var info:ResourceConfigInfo = getConfigInfo(type) as ResourceConfigInfo; 
			if(info)
			{
				return RES_PATH + info.path + name + info.suffix;
			}
			return null;
		}
	}
}