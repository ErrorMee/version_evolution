package service.socket
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import module.interfaces.IDisposeObject;
	
	/**
	 * 发包包装
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SendPkg implements IDisposeObject
	{
		private var m_Bytes:ByteArray = new ByteArray;
		
		private var m_Crypt:ICrypt;
		
		public function SendPkg()
		{
			m_Bytes.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function setCrypt(crypt:ICrypt):void
		{
			m_Crypt = crypt;
		}
		
		public function pkg(bag:SendBag):ByteArray
		{
			if(null == bag) return null;
			m_Bytes.writeShort(bag.length - 4);
			m_Bytes.writeBytes(bag);
			
			if(SocketManager.FIRST_PKG_HEAD != bag.head)
			{//加密
				if(m_Crypt)
				{
					m_Crypt.encrypt(m_Bytes);
				}
			}
			
			bag.clear();
			return m_Bytes;
		}
		
		public function clear():void
		{
			m_Bytes.clear();
		}
		
		public function dispose():void
		{
			clear();
		}
	}
}