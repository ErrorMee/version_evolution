package Editor.module.GridEditorModule.gridPart
{
	import Editor.module.GridEditorModule.GridUtil;
	import Editor.module.GridEditorModule.config.CellConfig;
	import Editor.module.GridEditorModule.model.CellInfo;
	import Editor.module.GridEditorModule.model.GridEditEnum;
	import Editor.module.GridEditorModule.model.GridEvent;
	import Editor.module.GridEditorModule.model.GridModel;
	
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	import game.ui.GridEditor.CellUI;
	
	import morn.core.handlers.Handler;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class CellMediator extends Mediator
	{
		[Inject]
		public var i_CellConfig:CellConfig;
		[Inject]
		public var i_GridModel:GridModel;
		
		public function CellMediator()
		{
			super();
		}
		
		private function get view():CellView
		{
			return getViewComponent() as CellView;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			updateList();
			addEvent();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		private function addEvent():void
		{
			i_GridModel.addEventListener(GridEvent.GRID_CHANGE,onGridChange);
			
			i_GridModel.addEventListener(GridEvent.CELL_CHANGE,onCellChange);
			view.m_List.mouseHandler = new Handler(listMouser);
			view.m_List.addEventListener(MouseEvent.RIGHT_CLICK,onRightClick);
		}
		
		private function listMouser(e:MouseEvent,index:int):void
		{
			if(e.buttonDown)
			{
				i_GridModel.setCellWithBrush(index);
			}
			view.m_List.selectedIndex = index;
		}
		
		public function onRightClick(e:MouseEvent):void
		{
			if(e.type == MouseEvent.RIGHT_CLICK)
			{
				i_GridModel.changeCellType(view.m_List.selectedIndex);
			}
		}
		
		private function onCellChange(e:GridEvent):void
		{
			if(i_GridModel.m_GridEditType == GridEditEnum.CELL_EDIT)
			{
				var cellInfo:CellInfo = e.getData() as CellInfo;
				var cell:CellUI = view.m_List.getCell(GridUtil.getIndex(cellInfo.m_XNum,cellInfo.m_YNum)) as CellUI;
				showCell(cellInfo,cell);
			}
		}
		
		private function onGridChange(e:GridEvent):void
		{
			updateList();
		}
		
		private function updateList():void
		{
			if(view.m_Mask == null)
			{
				view.m_Mask = new Shape;
				
				view.m_Mask.graphics.beginFill(0xa8a8a8,0.6);
				
				view.m_Mask.graphics.drawRect(0,0,74 * i_GridModel.m_XNum - 10,74 - 10);
				
				view.addChild(view.m_Mask);
			}
			
			if(view.m_Bg == null)
			{
				view.m_Bg = new Shape;
				
				view.m_Bg.graphics.lineStyle(2,0x555555);
				view.m_Bg.graphics.beginFill(0x27408B,0.3);
				view.m_Bg.graphics.drawRect(-10,-10,74 * i_GridModel.m_XNum + 10,74 * i_GridModel.m_YNum + 10);
				
				view.addChildAt(view.m_Bg,0);
			}
			
			view.m_List.repeatX = i_GridModel.m_XNum;
			view.m_List.repeatY = i_GridModel.m_YNum;
			
			var index:int;
			for(var y:int = 0; y<i_GridModel.m_YNum; y++)
			{
				for(var x:int = 0; x<i_GridModel.m_XNum; x++)
				{
					var cellInfo:CellInfo = i_GridModel.getCell(x,y);
					var cell:CellUI = view.m_List.getCell(index) as CellUI;
					showCell(cellInfo,cell);
					index = GridUtil.getIndex(x,y) + 1;
				}
			}
		}
		
		private function showCell(cellInfo:CellInfo,cell:CellUI):void
		{
			cell.m_Value.text = "";//"(" + cellInfo.m_Value + ")";
			cell.m_Pos.text = "";//"(" + cellInfo.m_XNum + "," + cellInfo.m_YNum + ")";
			cellInfo.m_Index;
			
			var renderArr:Array = i_CellConfig.getUseCellss();
			var cellConfigInfos:Array = renderArr[cellInfo.m_Index];
			
			cell.m_IconAdd.visible = false;
			cell.m_BG.gotoAndStop(i_CellConfig.getCellIdIndex(cellConfigInfos[0]));
			if(cellConfigInfos.length > 1)
			{
				cell.m_IconAdd.visible = true;
//				cell.m_IconAdd.blendMode = BlendMode.ADD;
				cell.m_IconAdd.gotoAndStop(i_CellConfig.getCellIdIndex(cellConfigInfos[1]));
			}
		}
	}
}