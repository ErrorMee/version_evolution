package service.socket
{
	import config.service.ServiceConfigInfo;
	
	import flash.events.EventDispatcher;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import service.BagHandlerInfo;
	import service.BaseService;
	
	import structure.HashMap;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	[Event(name="SocketEvent::connect_success", type="service.socket.SocketEvent")]
	public class SocketManager extends EventDispatcher
	{
		public static const FIRST_PKG_HEAD:int = 0x000000;
		
		public static const SOCKET_PKG_HEAD_SIZE:int = 6;
		
		private var m_SocketConnect:SocketConnect;
		
		private var m_ReceivePkg:ReceivePkg;
		private var m_SendPkg:SendPkg;
		
		private var m_BagHandlers:HashMap = new HashMap;
		
		public function SocketManager()
		{
			if(null != g_Instance) return;
			g_Instance = this;
			m_SendPkg = new SendPkg;
			m_ReceivePkg = new ReceivePkg(this);
		}
		private static var g_Instance:SocketManager;
		public static function GetInstance():SocketManager
		{
			if(null == g_Instance)
			{
				g_Instance = new SocketManager;
			}
			return g_Instance;
		}
		
		public function createConnect(info:ServiceConfigInfo,autoClose:Boolean = false):void
		{
			if(m_SocketConnect)
			{
				return;
			}
			var socketConnect:SocketConnect = new SocketConnect(this,autoClose);
			socketConnect.connect(info);
			if(!autoClose)
			{
				m_SocketConnect = socketConnect;
			}
		}
		
		public function getConnect():SocketConnect
		{
			return m_SocketConnect;
		}
		
		public function createSendBag(code:uint,errorCode:int = 0):SendBag
		{
			return new SendBag(code,errorCode);
		}
		
		/**
		 * 发包
		 */
		public function send(bag:SendBag):Boolean
		{
			if(m_SocketConnect == null) return false;
			if(null == bag) return false;
			var bytes:ByteArray = m_SendPkg.pkg(bag);
			var sendFlag:Boolean = m_SocketConnect.send(bytes);
			m_SendPkg.clear();
			return sendFlag;
		}
		
		/**
		 * 收包
		 */
		public function receive(socket:Socket):void
		{
			m_ReceivePkg.receive(socket);
		}
		
		/**
		 * 启用加密
		 */
		public function useCrypt(encrypt:ICrypt):void
		{
			if(m_SendPkg) m_SendPkg.setCrypt(encrypt);
		}
		
		/**
		 * 分发
		 */
		public function receiveOut(pkg:ReceiveBag):void
		{
			var bagHead:int = pkg.head;
			var errorCode:int = pkg.errorCode;
			
			var handler:BagHandlerInfo = m_BagHandlers.get(bagHead) as BagHandlerInfo;
			if(null == handler || errorCode != 0)
			{
				throw new Error(bagHead + "协议尚未注册");
			}else{
				handler.m_Handler(pkg);
			}
		}
		
		public function addBagHandler(handler:HashMap):void
		{
			if(null == handler) return;
			for each(var head:int in handler.keyList)
			{
				if(!m_BagHandlers.get(head))
				{
					m_BagHandlers.put(head,handler.get(head));
				}
				else
				{
					throw new Error("重复添加协议号：" + head);
				}
			}
		}
		
		public function removeBagHandler(handler:HashMap):void
		{
			for each(var head:int in handler.keyList)
			{
				m_BagHandlers.removeAt(head);
			}
		}
		
		public function removeBagHandlerByHead(head:int):void
		{
			m_BagHandlers.removeAt(head);
		}
	}
}