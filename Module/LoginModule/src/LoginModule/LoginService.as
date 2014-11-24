package LoginModule
{
	import service.BaseService;
	import service.socket.ReceiveBag;
	import service.socket.SendBag;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LoginService extends BaseService
	{
		public function LoginService()
		{
			super();
		}
		
		override protected function initHandlers():void
		{
			registHandler(0x0101,onLogin);
		}
		
		public function login(loginId:String,password:String = "111111"):void
		{
			var bag:SendBag = i_SocketManager.createSendBag(0x0101);
			bag.writeUTF(loginId);
			bag.writeUTF(password);
			send(bag);
		}
		
		private function onLogin(pkg:ReceiveBag):void
		{
			trace("成功收到第一条逻辑协议...");
		}
	}
}