package service
{
	import flash.utils.Dictionary;
	
	import module.interfaces.IDisposeObject;
	
	import org.robotlegs.mvcs.Actor;
	
	import service.socket.SendBag;
	import service.socket.SocketManager;
	
	import structure.HashMap;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class BaseService extends Actor implements IDisposeObject
	{
		[Inject]
		public var i_SocketManager:SocketManager;
		
		protected var m_BagHandlerList:HashMap = new HashMap;
		
		public function BaseService()
		{
			super();
			initHandlers();
		}
		
		/**
		 * 统一处理所有响应包
		 */
		protected function initHandlers():void
		{
		}
		
		/**
		 * 注册单条响应
		 */
		protected function registHandler(head:int,handler:Function):void 
		{
			var handleInfo:BagHandlerInfo = new BagHandlerInfo;
			handleInfo.m_Handler = handler;
			m_BagHandlerList.put(head,handleInfo); 
			
		}
		protected function unRegistHandler(head:int):void 
		{
			m_BagHandlerList.removeAt(head);
			i_SocketManager.removeBagHandlerByHead(head);
		}
		
		public function startup():void  
		{
			i_SocketManager.addBagHandler(m_BagHandlerList);
		}
		
		protected function send(bag:SendBag):void
		{
			i_SocketManager.send(bag);
		}
		
		public function getBagHandlerList():HashMap
		{
			return m_BagHandlerList;
		}
		
		public function clear():void
		{
			i_SocketManager.removeBagHandler(m_BagHandlerList);
			m_BagHandlerList.clear();
		}
		
		public function dispose():void
		{
			clear();
		}
	}
}