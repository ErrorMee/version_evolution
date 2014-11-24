package module.model
{
	import module.interfaces.IDisposeObject;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModelActor extends Actor implements IDisposeObject
	{
		public function ModelActor()
		{
			super();
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		
		public function clear():void
		{
		}
		
		public function dispose():void
		{
		}
	}
}