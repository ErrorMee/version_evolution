package Editor.module.GridEditorModule.setPart
{
	import Editor.module.GridEditorModule.config.CellConfig;
	import Editor.module.GridEditorModule.config.CellConfigInfo;
	import Editor.module.GridEditorModule.config.WallConfig;
	import Editor.module.GridEditorModule.config.WallConfigInfo;
	import Editor.module.GridEditorModule.model.GridEditEnum;
	import Editor.module.GridEditorModule.model.GridEvent;
	import Editor.module.GridEditorModule.model.GridModel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.ui.GridEditor.SetItemUI;
	import game.ui.GridEditor.WallItemUI;
	
	import morn.core.handlers.Handler;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SetMediator extends Mediator
	{
		[Inject]
		public var i_CellConfig:CellConfig;
		[Inject]
		public var i_GridModel:GridModel;
		[Inject]
		public var i_WallConfig:WallConfig;
		
		public function SetMediator()
		{
			super();
		}
		
		private function get view():SetView
		{
			return getViewComponent() as SetView;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			view.m_ComboBox.selectedIndex = 0;
			addEvent();
			initGridList();
			initWallList();
			changeEditType();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		private function addEvent():void
		{
			i_GridModel.addEventListener(GridEvent.BRUSH_CHANGE,onBrushModelChange);
			view.m_Default.addEventListener(MouseEvent.CLICK,onClickDefault);
			view.m_Random.addEventListener(MouseEvent.CLICK,onClickRandom);
			view.m_All.addEventListener(MouseEvent.CLICK,onClickAll);
			
			view.m_ComboBox.addEventListener(Event.CHANGE,onComboChange);
			
			i_GridModel.addEventListener(GridEvent.GRID_EDIT_CHANGE,onEditChange);
		}
		
		private function onBrushModelChange(e:GridEvent):void
		{
			updateBrush();
		}
		
		private function updateBrush():void
		{
			var brushStr:String = "";
			if(i_GridModel.m_GridEditType == GridEditEnum.CELL_EDIT)
			{
				var renderArr:Array = i_CellConfig.getUseCellss();
				var cellIDs:Array = renderArr[i_GridModel.m_BrushIndex];
				
				var i:int = 0;
				for(;i<cellIDs.length;i++)
				{
					var cellConfigInfo:CellConfigInfo = cellIDs[i];
					brushStr += cellConfigInfo.name + "+";
				}
			}
			
			if(i_GridModel.m_GridEditType == GridEditEnum.WALL_EDIT)
			{
				renderArr = i_WallConfig.getConfigInfos(true);
				var wallConfigInfo:WallConfigInfo = renderArr[i_GridModel.m_WallBrush] as WallConfigInfo;
				if(wallConfigInfo)
				{
					brushStr = wallConfigInfo.name;
				}else{
					brushStr = "error";
				}
			}
			
			if(brushStr == "")
			{
				brushStr = "null";
			}
			
			view.m_BrushType.text = brushStr;
		}
		
		private function initGridList():void
		{
			i_GridModel.setBrushIndex(0);
			var renderArr:Array = i_CellConfig.getUseCellss();
			view.m_List.m_List.renderHandler = new Handler(listRender);
			view.m_List.m_List.array = renderArr;
			view.m_List.m_List.mouseHandler = new Handler(listMouser);
		}
		
		private function initWallList():void
		{
			i_GridModel.setWallBrush(0);
			var renderArr:Array = i_WallConfig.getConfigInfos(true);
			view.m_WallList.renderHandler = new Handler(listWallRender);
			view.m_WallList.array = renderArr;
			view.m_WallList.mouseHandler = new Handler(listWallMouser);
		}
		
		private function listWallRender(item:WallItemUI, index:int):void
		{
			var renderArr:Array = i_WallConfig.getConfigInfos(true);
			if(view.m_WallList.array.length > index)
			{
				item.m_Icon.gotoAndStop(index);
			}
		}
		
		private function listWallMouser(e:MouseEvent,index:int):void
		{
			if(e.type == MouseEvent.CLICK)
			{
				i_GridModel.setWallBrush(index);
			}
		}
		
		private function listRender(item:SetItemUI, index:int):void
		{
			var renderArr:Array = i_CellConfig.getUseCellss();
			if(view.m_List.m_List.array.length > index)
			{
				var cellConfigInfos:Array = view.m_List.m_List.array[index];
				item.m_IconAdd.visible = false;
				item.m_Icon.gotoAndStop(i_CellConfig.getCellIdIndex(cellConfigInfos[0]));
				if(cellConfigInfos.length > 1)
				{
					item.m_IconAdd.visible = true;
					item.m_IconAdd.gotoAndStop(i_CellConfig.getCellIdIndex(cellConfigInfos[1]));
				}
			}
		}
		
		private function listMouser(e:MouseEvent,index:int):void
		{
			if(e.type == MouseEvent.CLICK)
			{
				i_GridModel.setBrushIndex(index);
			}
		}
		
		private function onClickDefault(e:MouseEvent):void
		{
			i_GridModel.clearAll();
		}
		
		private function onClickRandom(e:MouseEvent):void
		{
			i_GridModel.randomAll();
		}
		
		private function onClickAll(e:MouseEvent):void
		{
			i_GridModel.all();
		}
		
		private function onComboChange(e:Event):void
		{
			i_GridModel.changeEditType(view.m_ComboBox.selectedIndex);
		}
		
		private function onEditChange(e:GridEvent):void
		{
			changeEditType();
		}
		
		private function changeEditType():void
		{
			if(i_GridModel.m_GridEditType == 0)
			{
				view.m_List.visible = true;
				view.m_WallList.visible = false;
			}
			
			if(i_GridModel.m_GridEditType == 1)
			{
				view.m_List.visible = false;
				view.m_WallList.visible = true;
			}
			updateBrush();
		}
	}
}