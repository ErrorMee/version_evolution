package service.socket
{
	import config.service.ServiceConfigInfo;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import module.interfaces.IDisposeObject;

	/**
	 * socket连接
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SocketConnect implements IDisposeObject
	{
		private var m_Socket:Socket;
		
		private var m_SocketManager:SocketManager;
		
		private var m_ServiceConfigInfo:ServiceConfigInfo;
		
		public function SocketConnect(socketManager:SocketManager,autoClose:Boolean)
		{
			m_SocketManager = socketManager;
			m_AutoClose = autoClose;
			init();
		}
		
		public function connect(info:ServiceConfigInfo):void
		{
			m_ServiceConfigInfo = info;
			m_Socket.connect(info.ip,info.port);
		}
		
		public function send(bytes:ByteArray):Boolean
		{
			if(null == m_Socket || !m_Socket.connected)
			{
				return false;
			}
			m_Socket.writeBytes(bytes);
			m_Socket.flush();
			return true;
		}
		
		private function socketDataHandler(event:ProgressEvent):void
		{
			if(m_Socket.bytesAvailable > 0)
			{
				m_SocketManager.receive(m_Socket);
			}
		}
		
		public function getServiceConfigInfo():ServiceConfigInfo
		{
			return m_ServiceConfigInfo;
		}
		
		public function clear():void
		{
			removeEvent();
			if(m_Socket && m_Socket.connected)
			{
				m_Socket.close();
			}
			m_SocketManager = null;
			m_ServiceConfigInfo = null;
		}
		
		public function dispose():void
		{
			clear();
		}
		
		/**
		 * 自动断开
		 */
		private var m_AutoClose:Boolean;
		private function checkAutoClose():void
		{
			if(m_AutoClose)
			{
				dispose();
			}
		}
		
		private function init():void
		{
			m_Socket = new Socket;
			initEvent();
		}
		
		private function initEvent():void
		{
			m_Socket.addEventListener(Event.CONNECT, connectHandler);
			m_Socket.addEventListener(Event.CLOSE, closeHandler);
			m_Socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			m_Socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			m_Socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function removeEvent():void
		{
			m_Socket.removeEventListener(Event.CONNECT, connectHandler);
			m_Socket.removeEventListener(Event.CLOSE, closeHandler);
			m_Socket.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			m_Socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			m_Socket.removeEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function connectHandler(event:Event):void
		{
			trace("connectHandler: " + event);
			m_Socket.removeEventListener(Event.CONNECT, connectHandler);
			m_SocketManager.dispatchEvent(new SocketEvent(SocketEvent.CONNECT_SUCCESS,this));
			checkAutoClose();
		}
		
		private function closeHandler(event:Event):void
		{
			trace("closeHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("ioErrorHandler: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("securityErrorHandler: " + event);
		}

	}
}