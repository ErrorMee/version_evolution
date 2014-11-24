package Editor.main
{
	import org.robotlegs.base.ContextEvent;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class MainContextEvent extends ContextEvent
	{
		public static const INIT_CONFIG:String = "init_config";
		
		public static const INIT_MODEL:String = "init_model";
		
		public static const INIT_MEDIATOR:String = "init_mediator";
		
		public function MainContextEvent(type:String, body:*=null)
		{
			super(type, body);
		}
	}
}