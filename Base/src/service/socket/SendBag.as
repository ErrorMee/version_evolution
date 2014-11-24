package service.socket
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 原始发送包
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SendBag extends ByteArray
	{
		private var m_Head:int;
		
		public function SendBag(code:int,errorCode:int)
		{
			endian = Endian.LITTLE_ENDIAN;
			m_Head = code;
			writeShort(m_Head);
			writeShort(errorCode);
		}
		
		public function get head():int
		{
			return m_Head;
		}
		
		public function getSendDate():ByteArray
		{
			return null;
		}
	}
}