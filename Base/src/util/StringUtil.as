package util
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StringUtil
	{
		public static function rtl(str:String):String
		{
			var myPattern:RegExp = /\\/g;  
			return str.replace(myPattern,"/");
		}
	}
}