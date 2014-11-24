package module.interfaces
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public interface IDisposeObject
	{
		/**
		 *	清理
		 */
		function clear():void;
		
		/**
		 *	销毁
		 */
		function dispose():void;
	}
}