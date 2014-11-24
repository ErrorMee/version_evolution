package module.event
{
	import flash.events.Event;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class BaseEvent extends Event
	{
		protected var m_Data:Object
		
		public function BaseEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			m_Data = data;
		}
		
		public function getData():Object
		{
			return m_Data;
		}
		
		override public function clone():Event
		{
			var evt:BaseEvent = new BaseEvent(this.type,m_Data);
			return evt;
		}
	}
}