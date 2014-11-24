package org.rl_extends
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class DataActor extends Actor
	{
		public function DataActor()
		{
			super();
		}
		
		public function addEventListener(type:String,listener:Function):void
		{
			_eventDispatcher.addEventListener(type,listener);
		}
		
		public function removeEventListener(type:String,listener:Function):void
		{
			_eventDispatcher.removeEventListener(type,listener);
		}
	}
}