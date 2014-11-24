package config.service
{
	import config.base.BaseConfigInfo;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ServiceConfigInfo extends BaseConfigInfo
	{
		public var ip:String;
		
		public var port:int;
		
		public function ServiceConfigInfo()
		{
			super();
		}
		
		public function clone():ServiceConfigInfo
		{
			var serviceConfigInfo:ServiceConfigInfo = new ServiceConfigInfo();
			serviceConfigInfo.id = id;
			serviceConfigInfo.ip = ip;
			serviceConfigInfo.port = port;
			return serviceConfigInfo;
		}
		
	}
}