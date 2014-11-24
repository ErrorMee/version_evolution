package Common.config.lang
{
	import config.base.BaseConfig;
	
	import structure.HashMap;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LanguageConfig extends BaseConfig
	{
		private static var g_Instance:LanguageConfig;
		public function LanguageConfig()
		{
			if(null != g_Instance) return;
			g_Instance = this;
		}
		
		public static function GetInstance():LanguageConfig
		{
			return g_Instance;
		}
		
		override public function parseXML(data:XML, cls:Class, asyn:Boolean=false):void
		{
			var dataList:XMLList = data..i;
			var len:uint = dataList.length();
			for(var i:uint = 0; i < len; i++)
			{
				var words:XML = XML(dataList[i]);
				var type:String = words.@id;
				var hash:HashMap = getConfigList();
				if(hash.containsKey(type))
				{
					trace("发出警告：语言包重复ID--" + type);
				}
				else
				{
					hash.put(type,words.toString());
				} 
			}
		}
		
		public function getWords(type:String):String
		{
			if(getConfigList().containsKey(type))
				return getConfigList().get(type).toString(); 
			return "";
		}
		
		/**
		 * 连接多个type
		 */
		public function linkWords(...typeArr):String
		{
			var linkStr:String = "";
			var len:int = typeArr.length;
			var i:int;
			for(i=0;i<len;i+=1)
			{
				var type:String = typeArr[i].toString();
				if(getConfigList().containsKey(type))
				{
					linkStr += getConfigList().get(type).toString();
				}
			}
			return linkStr;
		}
		
		/**
		 * 传参数字符串
		 */
		public function getReplaceWords(type:String,replace:Array):String
		{
			var str:String =  getConfigList().get(type).toString();
			if(null == str) return "";
			var index:int = 0;
			for each(var word:String in replace)
			{
				str = str.replace("{" + index + "}",word);
				index++;
			}
			return str;
		}
	}
}