package Editor.module.GridEditorModule.model
{
	import module.event.BaseEvent;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridEvent extends BaseEvent
	{
		public static const GRID_EDITOR_START:String = "grid_editor_start";
		
		public static const GRID_CHANGE:String = "grid_change";
		
		public static const CELL_CHANGE:String = "cell_change";
		
		public static const BRUSH_CHANGE:String = "brush_change";
		
		public static const GRID_LOAD_COMPLETE:String = "grid_load_complete";
		
		public static const GRID_EDIT_CHANGE:String = "grid_edit_change";
		
		public function GridEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}