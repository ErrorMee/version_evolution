package Editor.module.GridEditorModule.gridPart
{
	import Editor.module.GridEditorModule.config.WallConfig;
	import Editor.module.GridEditorModule.model.CellInfo;
	import Editor.module.GridEditorModule.model.GridEditEnum;
	import Editor.module.GridEditorModule.model.GridEvent;
	import Editor.module.GridEditorModule.model.GridModel;
	
	import flash.events.MouseEvent;
	
	import game.ui.GridEditor.WallItemUI;
	
	import morn.core.handlers.Handler;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class WallMediator extends Mediator
	{
		[Inject]
		public var i_WallConfig:WallConfig;
		[Inject]
		public var i_GridModel:GridModel;
		
		private var LGN:int;
		private var LW:int = 74;
		
		public function WallMediator()
		{
			super();
		}
		
		private function get view():WallView
		{
			return getViewComponent() as WallView;
		}
		
		override public function onRegister():void
		{
			LGN = i_GridModel.m_XNum*2 - 1;
			
			view.m_List.repeatX = LGN;
			view.m_List.repeatY = i_GridModel.m_YNum;
			
			super.onRegister();
			initList();
			addEvent();
		}
		
		private function addEvent():void
		{
			i_GridModel.addEventListener(GridEvent.GRID_CHANGE,onGridChange);
			
			i_GridModel.addEventListener(GridEvent.CELL_CHANGE,onCellChange);
			
			view.m_List.mouseHandler = new Handler(listMouser);
			view.m_List.addEventListener(MouseEvent.RIGHT_CLICK,onRightClick);
		}
		
		private function onCellChange(e:GridEvent):void
		{
			if(i_GridModel.m_GridEditType == GridEditEnum.WALL_EDIT)
			{
				view.m_List.array = new Array(LGN*i_GridModel.m_YNum);
			}
		}
		
		public function onRightClick(e:MouseEvent):void
		{
			if(e.type == MouseEvent.RIGHT_CLICK)
			{
				i_GridModel.changeCellType(view.m_List.selectedIndex);
			}
		}
		
		private function onGridChange(e:GridEvent):void
		{
			if(i_GridModel.m_GridEditType == GridEditEnum.WALL_EDIT)
			{
				view.m_List.array = new Array(LGN*i_GridModel.m_YNum);
			}
		}
		
		private function initList():void
		{
			view.m_List.renderHandler = new Handler(listRender);
			view.m_List.array = new Array(LGN*i_GridModel.m_YNum);
		}
		
		private function listRender(item:WallItemUI, index:int):void
		{
			if(view.m_List.array.length > index)
			{
				var sindex:int = index%LGN + 1;//1 -17
				var yNum:int = int(index/LGN) + 1;//1 - 9
				
				var tox:int = 0;
				var toy:int = 0;
				var toangle:Number = 0;
				
				if(sindex <= Math.ceil(LGN/2))//1 - 9
				{
					tox = (sindex - 0.5)*LW;
					toy = (yNum - 1)*LW;
					toangle = 0;
				}else{//10 - 17
					sindex -= 9;
					tox = (sindex - 0.0)*LW;
					toy = (yNum - 0.5)*LW;
					toangle = 90;
				}
				
				item.x = tox + 5;
				item.y = toy + 5;
				item.rotation = toangle;
				item.scaleX = 1.15;
				
				var walls:Vector.<CellInfo> = GridModel.getInstance().getWalls();
				var cell:CellInfo = walls[index];
				item.m_Icon.gotoAndStop(cell.m_Index);
			}
		}
		
		private function listMouser(e:MouseEvent,index:int):void
		{
			if(e.buttonDown)
			{
				i_GridModel.setCellWithBrush(index);
			}
			view.m_List.selectedIndex = index;
		}
	}
}