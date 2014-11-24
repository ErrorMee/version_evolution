package Editor.module.GridEditorModule
{
	import Editor.module.GridEditorModule.model.GridModel;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridUtil
	{
		public static function getIndex(x:int,y:int):int
		{
			var index:int = y * GridModel.getInstance().m_XNum + x;
			return index;
		}
		
		public static function getX(index:int):int
		{
			return index%GridModel.getInstance().m_XNum;
		}
		
		public static function getY(index:int):int
		{
			return index/GridModel.getInstance().m_XNum;
		}
	}
}