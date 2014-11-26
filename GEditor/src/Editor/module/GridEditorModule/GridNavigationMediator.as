package Editor.module.GridEditorModule
{
	import Editor.module.GridEditorModule.model.GridEvent;
	import Editor.module.GridEditorModule.model.GridModel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridNavigationMediator extends Mediator
	{
		[Inject]
		public var i_GridModel:GridModel;
		
		public function GridNavigationMediator()
		{
			super();
		}
		
		private function get view():GridNavigationView
		{
			return getViewComponent() as GridNavigationView;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			addEvent();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			removeEvent();
		}
		
		private function addEvent():void
		{
			view.m_Create.addEventListener(MouseEvent.CLICK,onClickCreate);
			view.m_Save.addEventListener(MouseEvent.CLICK,onClickSave);
			view.m_Open.addEventListener(MouseEvent.CLICK,onClickOpen);
			addContextListener(GridEvent.GRID_EDITOR_START,onGridEditorStart);
			i_GridModel.addEventListener(GridEvent.GRID_LOAD_COMPLETE,onGridLoadComplete);
			i_GridModel.addEventListener(GridEvent.GRID_EDIT_CHANGE,onEditChange);
		}
		
		private function removeEvent():void
		{
			view.m_Create.removeEventListener(MouseEvent.CLICK,onClickCreate);
			view.m_Save.removeEventListener(MouseEvent.CLICK,onClickSave);
			view.m_Open.removeEventListener(MouseEvent.CLICK,onClickOpen);
			removeContextListener(GridEvent.GRID_EDITOR_START,onGridEditorStart);
		}
		
		private function onGridEditorStart(e:GridEvent):void
		{
			i_GridModel.create();
			initChild();
		}
		
		private function onGridLoadComplete(e:GridEvent):void
		{
			initChild();
		}
		
		private function initChild():void
		{
			if(!view.contains(view.m_GridView))
			{
				view.addChild(view.m_GridView);
			}
			if(!view.contains(view.m_WallView))
			{
				view.addChild(view.m_WallView);
			}
			if(!view.contains(view.m_SetView))
			{
				view.addChild(view.m_SetView);
			}
			if(!view.contains(view.m_PlayView))
			{
				view.addChild(view.m_PlayView);
			}
			changeEditType();
		}
		
		private function onEditChange(e:GridEvent):void
		{
			changeEditType();
		}
		
		private function changeEditType():void
		{
			if(i_GridModel.m_GridEditType == 0)
			{
				view.m_WallView.mouseEnabled = view.m_WallView.mouseChildren = view.m_WallView.visible = false;
				view.m_GridView.mouseEnabled = view.m_GridView.mouseChildren = true;
				view.m_GridView.alpha = 1;
			}
			
			if(i_GridModel.m_GridEditType == 1)
			{
				view.m_WallView.mouseEnabled = view.m_WallView.mouseChildren = view.m_WallView.visible = true;
				view.m_GridView.mouseEnabled = view.m_GridView.mouseChildren = false;
				view.m_GridView.alpha = 0.9;
			}
		}
		
		private function onClickCreate(e:MouseEvent):void
		{
			if(view.contains(view.m_CreateView))
			{
				view.removeChild(view.m_CreateView);
			}else{
				view.addChild(view.m_CreateView);
			}
		}
		
		private var m_File:File;
		private function onClickSave(e:MouseEvent):void
		{
			m_File = File.applicationDirectory.resolvePath("griddata/" + i_GridModel.m_ID + ".dat" );
			m_File.browseForSave("保存网格文件");
			m_File.addEventListener(Event.SELECT,saveSceneHandler);
		}
		
		private function saveSceneHandler(e:Event):void
		{
			m_File.removeEventListener(Event.SELECT,saveSceneHandler);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(m_File,FileMode.WRITE);
			i_GridModel.saveData(fileStream);
			fileStream.close();
		}
		
		private function onClickOpen(e:MouseEvent):void
		{
			m_File = File.applicationDirectory.resolvePath("griddata/");
			m_File.browseForOpen("选择网格文件",[new FileFilter("DAT(*.dat)","*.dat")]);
			m_File.addEventListener(Event.SELECT,loadHandler);
		}
		
		private function loadHandler(e:Event):void
		{
			m_File.removeEventListener(Event.SELECT,loadHandler);
			m_File.addEventListener(Event.COMPLETE,loadFileCompleteHandler);
			m_File.load();
		}
		
		private function loadFileCompleteHandler(e:Event):void
		{
			i_GridModel.loadData(m_File.data);
		}		
	}
}