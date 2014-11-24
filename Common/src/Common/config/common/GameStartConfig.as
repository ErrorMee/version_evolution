package Common.config.common
{
	import config.base.BaseConfig;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GameStartConfig extends BaseConfig
	{
		public var m_HungryZip:Boolean = false;
		
		public var m_HungryPath:String;
		
		public var m_GameVersion:String;
		
		public function GameStartConfig()
		{
			if(null != g_Instance)
			{
				return;
			}
			g_Instance = this;
		}
		private static var g_Instance:GameStartConfig;
		public static function GetInstance():GameStartConfig
		{
			return g_Instance;
		}
	}
}