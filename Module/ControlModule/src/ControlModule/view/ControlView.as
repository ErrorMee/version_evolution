package ControlModule.view
{
	import Common.morncode.Control.ControlUI;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明: 约定view不处理事件 所有事件移交Mediator  好处是统一了事件 管理 坏处是破坏view的可移植性
	 */
	public class ControlView extends ControlUI
	{
		private var m_Profiling:Profiling;
		
		public function ControlView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			m_ControlLayer.m_LogText.mouseChildren = false;
			m_ControlLayer.m_LogText.mouseEnabled = false;
			m_ControlLayer.m_LogText.alpha = 0.5;
		}
		
		public function useStats(open:Boolean):void
		{
			if(open)
			{
				if(!m_Profiling)
				{
					m_Profiling = new Profiling();
					addChildAt(m_Profiling,0);
				}
			}else{
				if(m_Profiling)
				{
					m_Profiling.parent.removeChild(m_Profiling);
					m_Profiling = null;
				}
			}
		}
		
		public function useLog(open:Boolean):void
		{
			if(m_ControlLayer.m_LogText == null)
			{
				return;
			}
			if(open)
			{
				if(!m_ControlLayer.parent)
				{
					addChild(m_ControlLayer);
				}
			}else{
				if(m_ControlLayer.parent)
				{
					m_ControlLayer.parent.removeChild(m_ControlLayer);
				}
			}
		}
		
		public function destroyLog():void
		{
			if(m_ControlLayer != null)
			{
				if(m_ControlLayer.parent)
				{
					m_ControlLayer.parent.removeChild(m_ControlLayer);
				}
				m_ControlLayer.m_LogText.textField.text = "";
				m_ControlLayer = null;
				return;
			}
		}
		
		public function addLog(logHtml:String):void
		{
			m_ControlLayer.m_LogText.appendText("\n" + logHtml);
			
			if(m_ControlLayer.m_LogText.textField.numLines >= 1000)
			{
				m_ControlLayer.m_LogText.text = "";
			}
			m_ControlLayer.m_LogText.textField.scrollV = m_ControlLayer.m_LogText.textField.numLines;
		}
		
	}
}