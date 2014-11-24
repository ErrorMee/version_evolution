package util
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class DateUtil
	{
		public static const YEAR_STR:String 	= "年";
		public static const MOUTH_STR:String 	= "月";
		public static const DAY_STR:String 		= "日";
		public static const HOURS_STR:String 	= "时";
		public static const MINUTES_STR:String 	= "分";
		public static const SECONDS_STR:String 	= "秒";
		
		/**
		 * @return 0000年00月00日 00:00:00
		 */
		public static function getDateString(d:Date,useSeconds:Boolean = true):String
		{
			return getYMDStr(d) + " " + getHMSStr(d,useSeconds);
		}
		
		/**
		 * @return 0000年00月00日
		 */
		public static function getYMDStr(d:Date):String
		{
			var mouth:int = d.month+1;
			var day:int = d.date;
			return d.fullYear + YEAR_STR + (mouth < 10 ? "0"+mouth : mouth) + MOUTH_STR + (day < 10 ? "0"+day : day) + DAY_STR;
		}
		
		/**
		 * @return 00:00:00
		 */
		public static function getHMSStr(d:Date,useSeconds:Boolean = true):String
		{
			var hours:int = d.hours;
			var minutes:int = d.minutes;
			var seconds:int = d.seconds;
			if(useSeconds)
			{
				return (hours < 10 ? "0"+hours.toString() : hours.toString())+":"+
						(minutes < 10 ? "0"+minutes.toString() : minutes.toString())+":"+ (seconds < 10 ? "0"+seconds.toString() : seconds.toString());
			}
			return (hours < 10 ? "0"+hours.toString() : hours.toString())+":"+(minutes < 10 ? "0"+minutes.toString() : minutes.toString());
		}
		
		/**
		 * @return Date
		 */
		public static function getDate(time:int):Date
		{
			var d:Date = new Date(time);
			var t:int = d.timezoneOffset;
			var h:int = t/60;
			var m:int = t%60;
			d.hours += h;
			d.minutes += m;
			return d;
		}
	}
}