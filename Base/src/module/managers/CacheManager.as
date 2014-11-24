package module.managers
{
	import flash.events.NetStatusEvent;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.system.Security;
	import flash.system.SecurityPanel;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class CacheManager
	{
		private var m_ShareObject:SharedObject;
		
		public function CacheManager(name:String = "project_tesla")
		{
			m_ShareObject = SharedObject.getLocal(name);
			m_ShareObject.objectEncoding = ObjectEncoding.AMF3;
		}
		
		public function showSetting():void 
		{
			Security.showSettings(SecurityPanel.LOCAL_STORAGE);
		}
		
		public function setAt(key:String,value:Object):void 
		{
			if (value != null) 
			{
				m_ShareObject.setProperty(key, value);
			} 
			else 
			{
				delete m_ShareObject.data[key];
			}
		}
		
		public function getAt(key:String):Object 
		{
			return m_ShareObject.data[key];
		}
		
		public function flush():Boolean 
		{
			var done:Boolean = true;
			try 
			{
				var result:Object = m_ShareObject.flush();
				if(result == SharedObjectFlushStatus.PENDING) 
				{
					done = false;
				}
			}
			catch(e:Error) 
			{
				done = false;
			}
			return done;
		}
		
		public function clear():void 
		{
			m_ShareObject.clear();
		}
	}
}