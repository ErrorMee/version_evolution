package Editor.module.GridEditorModule.model
{
	public class CellInfo
	{
		public var m_XNum:int;
		public var m_YNum:int;
		public var m_Index:int;
		
		public function copy():CellInfo
		{
			var gridInfo:CellInfo = new CellInfo();
			gridInfo.m_XNum = m_XNum;
			gridInfo.m_YNum = m_YNum;
			gridInfo.m_Index = m_Index;
			return gridInfo;
		}
	}
}