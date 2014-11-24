package ControlModule.view
{
	import config.module.ModuleConfig;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import module.mediator.ModuleMediator;
	
	import morn.core.components.Button;
	import morn.core.components.Component;
	import morn.core.handlers.Handler;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class TestMediator extends ModuleMediator
	{
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		private var m_Timer:Timer;
		
		public function TestMediator()
		{
			super();
		}
		
		private function get view():ControlView
		{
			return getViewComponent() as ControlView;
		}
		
		override protected function initView():void
		{
			view.m_ControlLayer.m_FunList.renderHandler = new Handler(listRender);
			view.m_ControlLayer.m_FunList.array = ["DestroyTest","SpineTest","Test1","Test2","Test3","Test4"];
		}
		
		override protected function initEvent():void
		{
			view.m_ControlLayer.m_FunList.addEventListener(Event.CHANGE,onListChange);
		}
		
		override protected function removeEvent():void
		{
			view.m_ControlLayer.m_FunList.removeEventListener(Event.CHANGE,onListChange);
		}
		
		private function listRender(item:Component, index:int):void
		{
			if (index < view.m_ControlLayer.m_FunList.length) 
			{
				var button:Button = item.getChildByName("m_Button") as Button;
				button.label = view.m_ControlLayer.m_FunList.array[index];
			}
		}
		
		private function onListChange(e:Event):void
		{
			switch(view.m_ControlLayer.m_FunList.selectedIndex)
			{
				case 0:
					onClickDestroy();
					break;
				case 1:
					onClickSpine();
					break;
				case 2:
					onClickTest();
					break;
			}
		}
		
		private function onClickSpine():void
		{
			closeModule(i_ModuleConfig.getModuleDevName(10001),true);
			openModule(i_ModuleConfig.getModuleDevName(20002));
		}
		
		private function onClickDestroy():void
		{
			m_Timer = new Timer(200,200);
			m_Timer.addEventListener(TimerEvent.TIMER,onTimer);
			m_Timer.start();
			view.m_ControlLayer.m_FunList.getCell(0).visible = false;
		}
		
		private function onTimer(e:TimerEvent):void
		{
			if(m_Timer.currentCount%2)
			{
				closeModule(i_ModuleConfig.getModuleDevName(10001),true);
			}else{
				openModule(i_ModuleConfig.getModuleDevName(10001));
			}
		}
		
		private function onClickTest():void
		{
			trace("test 我真的好寂寞 该做点什么呢？");
		}
	}
}