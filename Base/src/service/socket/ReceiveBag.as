package service.socket
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ReceiveBag extends ByteArray
	{
		private var m_Head:int = -1;
		private var m_ErrorCode:int = 0;
		
		public function ReceiveBag(bodyLen:uint,src:ByteArray)
		{
			endian = Endian.LITTLE_ENDIAN;
			if(0 == bodyLen) return;
			if(src)
			{
				src.readBytes(this,0,bodyLen);
			}
		}
		
		public function set head(value:int):void
		{
			m_Head = value;
		}
		
		public function get head():int
		{
			return m_Head;
		}
		
		public function set errorCode(value:int):void
		{
			m_ErrorCode = value;
		}
		
		public function get errorCode():int
		{
			return m_ErrorCode;
		}
	}
}