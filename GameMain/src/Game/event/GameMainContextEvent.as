package Game.event
{
	import org.robotlegs.base.ContextEvent;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GameMainContextEvent extends ContextEvent
	{
		public static const INIT_COMMON:String = "init_common";
		
		public static const INIT_CONFIG:String = "init_config";
		
		public static const INIT_ACTOR:String = "init_actor";
		
		public static const INIT_GAME_MAIN:String = "init_gamemain";
		
		public static const INIT_NET:String = "init_net";
		
		public static const INIT_CONTROL:String = "init_control";
		
		public function GameMainContextEvent(type:String, body:*=null)
		{
			super(type, body);
		}
	}
}