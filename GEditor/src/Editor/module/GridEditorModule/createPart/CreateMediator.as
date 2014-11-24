package Editor.module.GridEditorModule.createPart
{
	import Editor.module.GridEditorModule.model.GridEvent;
	import Editor.module.GridEditorModule.model.GridModel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class CreateMediator extends Mediator
	{
		[Inject]
		public var i_GridModel:GridModel;
		
		public function CreateMediator()
		{
			super();
		}
		
		private function get view():CreateView
		{
			return getViewComponent() as CreateView;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			view.m_ID.text = "10000";
			view.m_XNum.text = "9";
			view.m_YNum.text = "10";
			view.m_UYNum.text = "2";
			addEvent();
		}
		
		private function addEvent():void
		{
			view.m_Close.addEventListener(MouseEvent.CLICK,onClickClose);
			view.m_Sure.addEventListener(MouseEvent.CLICK,onClickSure);
			
			view.m_XNum.addEventListener(Event.CHANGE,onInputChange);
			view.m_YNum.addEventListener(Event.CHANGE,onInputChange);
			view.m_UYNum.addEventListener(Event.CHANGE,onInputChange);
		}
		
		private function onClickClose(e:MouseEvent):void
		{
			view.parent.removeChild(view);
		}
		
		private function onClickSure(e:MouseEvent):void
		{
			view.parent.removeChild(view);
			
			i_GridModel.m_ID = int(view.m_ID.text);
			i_GridModel.m_XNum = int(view.m_XNum.text);
			i_GridModel.m_YNum = int(view.m_YNum.text);
			i_GridModel.m_UYNum = int(view.m_UYNum.text);
			dispatch(new GridEvent(GridEvent.GRID_EDITOR_START));
		}
		
		private function onInputChange(e:Event):void
		{
			if(int(view.m_YNum.text) < 1)
			{
				view.m_YNum.text = "1";
				return;
			}
			if(int(view.m_XNum.text) < 1)
			{
				view.m_XNum.text = "1";
				return;
			}
			
			if(int(view.m_UYNum.text) < 1)
			{
				view.m_UYNum.text = "1";
				return;
			}
			if(int(view.m_UYNum.text) >= int(view.m_YNum.text))
			{
				view.m_UYNum.text = "1";
				return;
			}
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			removeEvent();
		}
		
		private function removeEvent():void
		{
			view.m_Close.removeEventListener(MouseEvent.CLICK,onClickClose);
			view.m_Sure.removeEventListener(MouseEvent.CLICK,onClickSure);
			
			view.m_XNum.removeEventListener(Event.CHANGE,onInputChange);
			view.m_YNum.removeEventListener(Event.CHANGE,onInputChange);
		}
	}
}