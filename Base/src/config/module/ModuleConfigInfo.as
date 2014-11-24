package config.module
{
	import config.base.BaseConfigInfo;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleConfigInfo extends BaseConfigInfo
	{
		public var name:String;
		
		public var dev_name:String;
		
		public var libs:String;
		
		public var glibs:String;
		
		public function ModuleConfigInfo()
		{
			super();
		}
	}
}