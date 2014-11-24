package LoginModule
{
	import config.module.ModuleConfig;
	import config.service.ServiceConfig;
	import config.service.ServiceConfigInfo;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import module.managers.CacheEnum;
	import module.managers.CacheManager;
	import module.mediator.ModuleMediator;
	
	import morn.core.components.Button;
	import morn.core.components.Component;
	import morn.core.handlers.Handler;
	
	import service.socket.SendBag;
	import service.socket.SocketConnect;
	import service.socket.SocketEvent;
	import service.socket.SocketManager;
	
	import util.VisualUtil;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LoginMediator extends ModuleMediator
	{
		[Inject]
		public var i_ServiceConfig:ServiceConfig;
		[Inject]
		public var i_CacheManager:CacheManager;
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		[Inject]
		public var i_LoginService:LoginService;
		
		public function LoginMediator()
		{
			super();
		}
		
		private function get view():LoginView
		{
			return getViewComponent() as LoginView;
		}
		
		override protected function initView():void
		{
			view.x = (view.stage.stageWidth - view.width) >> 1;
			view.y = (view.stage.stageHeight - view.height) >> 1;
			
			view.m_ServerList.renderHandler = new Handler(listRender);
			view.m_ServerList.array = [];
			
			var userLoginId:String = String(i_CacheManager.getAt(CacheEnum.USER_LOGIN_ID.m_Name));
			if("null" == userLoginId) userLoginId = "";
			view.m_User.text = userLoginId;
			
			VisualUtil.setTextFocus(view.m_User.textField);
		}
		
		private function listRender(item:Component, index:int):void
		{
			if (index < view.m_ServerList.length) 
			{
				var button:Button = item.getChildByName("m_Button") as Button;
				button.label = (view.m_ServerList.array[index] as ServiceConfigInfo).id;
			}
		}
		
		override protected function initEvent():void
		{
			view.m_ServerList.addEventListener(Event.CHANGE,onRealConnect);
			SocketManager.GetInstance().addEventListener(SocketEvent.CONNECT_SUCCESS,onConnectSuccess);
			SocketManager.GetInstance().addEventListener(SocketEvent.LOGIN_READY_SUCCESS,onLoginReady);
			initConnect();
		}
		
		private function onRealConnect(e:Event = null):void
		{
			if(view.m_User.text && view.m_User.text != "")
			{
				i_CacheManager.setAt(CacheEnum.USER_LOGIN_ID.m_Name,view.m_User.text);
				SocketManager.GetInstance().createConnect(view.m_ServerList.selectedItem as ServiceConfigInfo);
			}
		}
		
		private function initConnect():void
		{
			var dic:Dictionary = i_ServiceConfig.getConfigDic();
			for each(var info:ServiceConfigInfo in dic)
			{
				SocketManager.GetInstance().createConnect(info,true);
			}
		}
		
		private function onConnectSuccess(e:SocketEvent):void
		{
			if(SocketManager.GetInstance().getConnect())
			{
				SocketManager.GetInstance().removeEventListener(SocketEvent.CONNECT_SUCCESS,onConnectSuccess);
				view.m_ServerList.removeEventListener(Event.CHANGE,onRealConnect);
				log("链接服务器：" + (view.m_ServerList.selectedItem as ServiceConfigInfo).ip,i_ModuleConfig.getModuleDevName(10001));
				view.m_ServerList.array = [];
				view.m_ServerList.renderHandler = null;
				
				var bag:SendBag = SocketManager.GetInstance().createSendBag(SocketManager.FIRST_PKG_HEAD);
				for(var i:int = 1; i <= 122; i++)
				{
					bag.writeByte(0);	
				}
				SocketManager.GetInstance().send(bag);
			}else{
				var connect:SocketConnect = e.getData() as SocketConnect;
				var info:ServiceConfigInfo = connect.getServiceConfigInfo();
				view.m_ServerList.array = view.m_ServerList.array.concat(info);
			}
		}
		
		private function onLoginReady(e:SocketEvent):void
		{
			SocketManager.GetInstance().removeEventListener(SocketEvent.LOGIN_READY_SUCCESS,onLoginReady);
			i_LoginService.login(view.m_User.text);
			closeModule(i_ModuleConfig.getModuleDevName(10001),true);
		}
	}
}