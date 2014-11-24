package service.socket
{
	import flash.utils.ByteArray;
	
	/******************************************************
	 *
	 * 创建者：errormee
	 * 功能：
	 * 说明：
	 *	 
	 ******************************************************/
	
	public interface ICrypt
	{
		/*
		 *	加密 
		*/
		function encrypt(src:ByteArray):void;
		
		/*
		 *	解密 
		*/
		function decrypt(src:ByteArray):void;
	}
}