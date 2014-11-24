package Editor.main
{
	import Editor.module.GridEditorModule.GridNavigationView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class MainMediator extends Mediator
	{
		public function MainMediator()
		{
			super();
		}
		
	    private function get view():MainView
		{
			return getViewComponent() as MainView;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			view.m_Navigation.m_Tab.dataSource = ["网格编辑"];
			
			addEvent();
		}
		
		private function addEvent():void
		{
			view.m_Navigation.m_Tab.addEventListener(Event.CHANGE,onNavigationChange);
		}
		
		private var m_ViewList:Array = [new GridNavigationView];
		private var m_CrtView:Sprite;
		private function onNavigationChange(e:Event):void
		{
			trace(view.m_Navigation.m_Tab.selectedIndex);
			var gotoView:Sprite = m_ViewList[view.m_Navigation.m_Tab.selectedIndex];
			
			if(m_CrtView && gotoView != m_CrtView)
			{
				view.removeChild(m_CrtView);
			}
			
			m_CrtView = gotoView;
			m_CrtView.y = 24;
			view.addChild(m_CrtView);
		}
	}
}