package Common.config.common
{
	import config.base.BaseConfigInfo;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GameStartConfigInfo extends BaseConfigInfo
	{
		public var asyn:int;
		
		public var className:String;
		
		public function GameStartConfigInfo()
		{
			super();
		}
		
		public function isXml():Boolean
		{
			if(id.search(".xml") != -1)
			{
				return true
			}
			return false;
		}
	}
}