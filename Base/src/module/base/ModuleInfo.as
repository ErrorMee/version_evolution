package module.base
{
	import flash.display.DisplayObjectContainer;
	
	import module.interfaces.IDisposeObject;
	
	import org.robotlegs.core.IInjector;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleInfo implements IDisposeObject
	{
		public var m_Name:String;
		
		public function ModuleInfo(name:String = ""):void
		{
			m_Name = name;
		}
		
		public function clear():void
		{
			m_Name = null;
		}
		
		public function dispose():void
		{
			clear();
		}
	}
}