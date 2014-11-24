package Editor.module.GridEditorModule.model
{
	import Editor.module.GridEditorModule.GridUtil;
	import Editor.module.GridEditorModule.config.CellConfig;
	import Editor.module.GridEditorModule.config.WallConfig;
	
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import module.model.ModelActor;

	public class GridModel extends ModelActor
	{
		[Inject]
		public var i_CellConfig:CellConfig;
		[Inject]
		public var i_WallConfig:WallConfig;
		
		public var m_BrushIndex:int;
		
		public var m_ID:int;
		public var m_XNum:int;
		public var m_YNum:int;
		public var m_UYNum:int;
		
		private var m_CellVector:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		public var m_GridEditType:int = 0;
		
		public var m_WallBrush:int;
		private var m_WallList:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		public static function getInstance():GridModel
		{
			return _instance;
		}
		private static  var _instance:GridModel;
		public function GridModel()
		{
			if(_instance)
			{
				throw new Error("只能用getInstance()来获取实例");
			}
			_instance = this;
		}
		
		public function create(random:Boolean = false):void
		{
			if(m_GridEditType == GridEditEnum.CELL_EDIT)
			{
				m_CellVector = new Vector.<CellInfo>;
				var cellInfo:CellInfo;
				var y:int;
				for(y = 0; y<m_YNum; y++)
				{
					var x:int;
					for(x = 0; x<m_XNum; x++)
					{
						cellInfo = new CellInfo;
						cellInfo.m_XNum = x;
						cellInfo.m_YNum = y;
						if(random)
						{
							cellInfo.m_Index = Math.random()*i_CellConfig.getUseCellss().length;
						}else{
							cellInfo.m_Index = m_BrushIndex;
						}
						
						m_CellVector.push(cellInfo);
					}
				}
			}
			
			if(m_GridEditType == GridEditEnum.WALL_EDIT || m_WallList.length < 1)
			{
				m_WallList = new Vector.<CellInfo>;
				var XNUM:int = m_XNum*2 - 1;
				for(y = 0; y<m_YNum; y++)
				{
					for(x = 0; x<XNUM; x++)
					{
						cellInfo = new CellInfo;
						cellInfo.m_XNum = x;
						cellInfo.m_YNum = y;
						if(random)
						{
							cellInfo.m_Index = Math.random()*i_WallConfig.getConfigInfos().length;
						}else{
							cellInfo.m_Index = m_WallBrush;
						}
						
						m_WallList.push(cellInfo);
					}
				}
			}
			
			dispatch(new GridEvent(GridEvent.GRID_CHANGE));
		}
		
		public function getCells():Vector.<CellInfo>
		{
			return m_CellVector;
		}
		
		public function getWalls():Vector.<CellInfo>
		{
			return m_WallList;
		}
		
		public function getCell(x:int,y:int):CellInfo
		{
			var index:int = GridUtil.getIndex(x,y);
			return m_CellVector[index];
		}
		
		public function getWall(index:int):CellInfo
		{
			return m_WallList[index];
		}
		
		public function setBrushIndex(index:int):void
		{
			m_BrushIndex = index;
			dispatch(new GridEvent(GridEvent.BRUSH_CHANGE));
		}
		
		public function setWallBrush(index:int):void
		{
			m_WallBrush = index;
			dispatch(new GridEvent(GridEvent.BRUSH_CHANGE));
		}
		
		public function setCellWithBrush(index:int):void
		{
			var cellInfo:CellInfo;
			if(m_GridEditType == GridEditEnum.CELL_EDIT)
			{
				cellInfo = getCell(GridUtil.getX(index),GridUtil.getY(index));
				if(cellInfo)
				{
					if(cellInfo.m_Index != m_BrushIndex || cellInfo.m_Index != m_BrushIndex)
					{
						cellInfo.m_Index = m_BrushIndex;
						dispatch(new GridEvent(GridEvent.CELL_CHANGE,cellInfo));
					}
				}
			}
			
			if(m_GridEditType == GridEditEnum.WALL_EDIT)
			{
				cellInfo = getWall(index);
				if(cellInfo)
				{
					cellInfo.m_Index = m_WallBrush;
					dispatch(new GridEvent(GridEvent.CELL_CHANGE,cellInfo));
				}
			}
		}
		
		public function changeCellType(index:int):void
		{
			if(index < 0)
			{
				return;
			}
			if(m_GridEditType == GridEditEnum.CELL_EDIT)
			{
				m_BrushIndex ++;
				if(m_BrushIndex >= i_CellConfig.getUseCellss().length)
				{
					m_BrushIndex = 0;
				}
			}
			
			if(m_GridEditType == GridEditEnum.WALL_EDIT)
			{
				m_WallBrush ++;
				if(m_WallBrush >= i_WallConfig.getConfigInfos().length)
				{
					m_WallBrush = 0;
				}
			}
			
			dispatch(new GridEvent(GridEvent.BRUSH_CHANGE));
			setCellWithBrush(index);
		}
		
		public function randomAll():void
		{
			create(true);
		}
		
		public function clearAll():void
		{
			setBrushIndex(0);
			setWallBrush(0);
			create();
		}
		
		public function all():void
		{
			create();
		}
		
		public function saveData(fileStream:FileStream):void
		{
			if(null == fileStream) return;
			var byteArray:ByteArray = new ByteArray;
			
			byteArray.writeShort(m_ID);
			byteArray.writeShort(m_XNum);
			byteArray.writeShort(m_YNum);
			
			var cellInfo:CellInfo;
			var y:int;
			var x:int;
			for(y = 0; y<m_YNum; y++)
			{
				for(x = 0; x<m_XNum; x++)
				{
					cellInfo = getCell(x,y);
					byteArray.writeByte(cellInfo.m_Index);
				}
			}
			
			for(y = 0;y<m_WallList.length;y++)
			{
				cellInfo =  m_WallList[y];
				byteArray.writeByte(cellInfo.m_Index);
			}
			
			fileStream.writeBytes(byteArray,0,byteArray.length);
		}
		
		public function loadData(data:ByteArray):void
		{
			if(null == data) return;
			data.position = 0;
			
			m_ID = data.readShort();
			m_XNum = data.readShort();
			m_YNum = data.readShort();
			
			m_CellVector = new Vector.<CellInfo>;
			var cellInfo:CellInfo;
			var y:int;
			var x:int;
			for(y = 0; y<m_YNum; y++)
			{
				for(x = 0; x<m_XNum; x++)
				{
					cellInfo = new CellInfo;
					cellInfo.m_XNum = x;
					cellInfo.m_YNum = y;
					
					cellInfo.m_Index = data.readByte();
					m_CellVector.push(cellInfo);
				}
			}
			
			m_WallList = new Vector.<CellInfo>;
			var wallsLen:int = (m_XNum*2 - 1) * m_XNum;
			for(y = 0;y<wallsLen;y++)
			{
				cellInfo = new CellInfo;
				cellInfo.m_Index = data.readByte();
				m_WallList.push(cellInfo);
			}
			
			dispatch(new GridEvent(GridEvent.GRID_LOAD_COMPLETE));
		}
		
		public function changeEditType(editType:int):void
		{
			m_GridEditType = editType;
			dispatch(new GridEvent(GridEvent.GRID_EDIT_CHANGE));
		}
	}
}