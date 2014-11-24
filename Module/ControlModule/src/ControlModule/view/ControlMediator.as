package ControlModule.view
{
	import Common.config.common.GameStartConfig;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	
	import module.base.ModuleInfo;
	import module.event.ModuleEvent;
	import module.event.ModuleEventInfo;
	import module.mediator.ModuleMediator;
	
	import morn.core.components.CheckBox;
	
	import util.DateUtil;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ControlMediator extends ModuleMediator
	{
		[Inject]
		public var i_GameStartConfig:GameStartConfig;
		
		private var m_LogFile:FileReference;
		
		public function ControlMediator()
		{
			super();
		}
		
		private function get view():ControlView
		{
			return getViewComponent() as ControlView;
		}
		
		override protected function initMediator():void
		{
			registerComponentMediator(view,ModulesMediator);
			registerComponentMediator(view,TestMediator);
		}
		
		override protected function initView():void
		{
			view.useLog(false);
		}
		
		override protected function initEvent():void
		{
			view.m_Check.addEventListener(MouseEvent.CLICK,onClickCheck);
			addModuleListener(ModuleEvent.ME_LOG.m_Name,onLogEvent);
			view.m_ControlLayer.m_SaveLog.addEventListener(MouseEvent.CLICK,onClickSave);
		}
		
		override protected function removeEvent():void
		{
			view.m_Check.removeEventListener(MouseEvent.CLICK,onClickCheck);
			removeModuleListener(ModuleEvent.ME_LOG.m_Name,onLogEvent);
			view.m_ControlLayer.m_SaveLog.removeEventListener(MouseEvent.CLICK,onClickSave);
		}
		
		private function onClickSave(e:MouseEvent):void
		{
			if(m_LogFile == null)
			{
				m_LogFile = new FileReference;
			}
			
			var log:String = "Version:" + i_GameStartConfig.m_GameVersion + "\r\n\r\n";
			log += view.m_ControlLayer.m_LogText.text;
			m_LogFile.save(log,"log.txt");
		}
		
		private function onLogEvent(e:ModuleEvent):void
		{
			var moduleEventInfo:ModuleEventInfo = e.getInfo();
			var logStr:String = DateUtil.getHMSStr(new Date) + "\t" + moduleEventInfo.m_ModuleFrom + "\t" + moduleEventInfo.m_Data;
			view.addLog(logStr);
			trace(logStr);
		}
		
		private function onClickCheck(e:MouseEvent):void
		{
			var checkBox:CheckBox = e.currentTarget as CheckBox;
			view.useStats(checkBox.selected);
			view.useLog(checkBox.selected);
		}
	}
}