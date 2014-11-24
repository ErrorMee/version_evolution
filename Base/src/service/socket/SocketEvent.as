package service.socket
{
	import module.event.BaseEvent;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SocketEvent extends BaseEvent
	{
		public static const CONNECT_SUCCESS:String = "SocketEvent::connect_success";
		public static const LOGIN_READY_SUCCESS:String = "SocketEvent::login_ready_success";
		public function SocketEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}