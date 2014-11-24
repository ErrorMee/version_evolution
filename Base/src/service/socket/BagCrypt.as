package service.socket
{
	import flash.utils.ByteArray;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class BagCrypt implements ICrypt
	{
		private var m_Key:int = 0;
		public function BagCrypt(key:int)
		{
			m_Key = key;
		}
		
		public function encrypt(src:ByteArray):void
		{
			for (var i:uint = 0 ; i <= 5; i++) 
			{
				src[i] ^= m_Key;
			}
			m_Key++;
			if(m_Key > 255) 
			{
				//服务端是个byte 超过255 重新置为1
				m_Key = 1;
			}
			m_Key &= 0xFF;
		}
		
		public function decrypt(src:ByteArray):void
		{
		}
	}
}