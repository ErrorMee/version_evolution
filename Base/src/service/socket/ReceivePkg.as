package service.socket
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import module.interfaces.IDisposeObject;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ReceivePkg implements IDisposeObject
	{
		private var m_Bytes:ByteArray = new ByteArray;
		private var m_SocketManager:SocketManager;
		
		private static const AUTHORIZED_LENGTH:uint = 162;	//授权包的长度	
		private var m_IsAuthorized:Boolean = false;			//是否收到授权（第一个包）
		
		private static const KEY_LENGTH:uint = 1;			//加密Key的长度
		private var m_IsReceiveKey:Boolean = false;			//是否收到加密Key（第二个包 注意 可能粘包）
		
		public function ReceivePkg(socketManager:SocketManager)
		{
			m_SocketManager = socketManager;
			m_Bytes.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function receive(socket:Socket):void
		{
			m_Bytes.clear();
			socket.readBytes(m_Bytes,0,socket.bytesAvailable);
			
			if(!m_IsAuthorized)//处理授权
			{
				if(m_Bytes.bytesAvailable >= AUTHORIZED_LENGTH)
				{
					m_IsAuthorized = true;
					m_Bytes.position += AUTHORIZED_LENGTH;
				}
				else return;
			}
			if(!m_IsReceiveKey)//处理加密
			{
				if(m_Bytes.bytesAvailable >= KEY_LENGTH)
				{
					m_IsReceiveKey = true;
					var key:int = m_Bytes.readByte();
					if(key)
					{
						var encrypt:ICrypt = new BagCrypt(key);
						m_SocketManager.useCrypt(encrypt);
					}
					m_SocketManager.dispatchEvent(new SocketEvent(SocketEvent.LOGIN_READY_SUCCESS));
				}
				else return;
			}
			
			if(m_Bytes.bytesAvailable > SocketManager.SOCKET_PKG_HEAD_SIZE)
			{
				logicBagHandler();
			}
		}
		
		/**
		 * 处理逻辑包
		 */
		private function logicBagHandler():void
		{
			do
			{
				var bagLen:int = m_Bytes.bytesAvailable;
				var bodyLen:int = m_Bytes.readShort();
				if((bagLen - SocketManager.SOCKET_PKG_HEAD_SIZE) >= bodyLen)
				{
					var head:int = m_Bytes.readShort();
					var errorCode:int = m_Bytes.readShort();
					var bag:ReceiveBag = new ReceiveBag(bodyLen,m_Bytes);
					bag.head = head;
					bag.errorCode = errorCode;
					m_SocketManager.receiveOut(bag);
				}
			}
			while(m_Bytes.bytesAvailable >= SocketManager.SOCKET_PKG_HEAD_SIZE);
		}
		
		public function clear():void
		{
			m_Bytes.clear();
		}
		
		public function dispose():void
		{
			clear();
			m_SocketManager = null;
		}
	}
}