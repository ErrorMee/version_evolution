package module.interfaces
{
	import flash.display.DisplayObjectContainer;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public interface ILayerManager
	{
		function setup(contextView:DisplayObjectContainer):void;
		
		function getLayer(type:String):DisplayObjectContainer;
	}
}