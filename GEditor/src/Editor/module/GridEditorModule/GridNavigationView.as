package Editor.module.GridEditorModule
{
	
	import Editor.module.GridEditorModule.createPart.CreateView;
	import Editor.module.GridEditorModule.gridPart.CellView;
	import Editor.module.GridEditorModule.gridPart.WallView;
	import Editor.module.GridEditorModule.playPart.PlayView;
	import Editor.module.GridEditorModule.setPart.SetView;
	
	import game.ui.GridEditor.NavigationUI;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridNavigationView extends NavigationUI
	{
		public var m_CreateView:CreateView;
		
		public var m_SetView:SetView;
		
		public var m_PlayView:PlayView;
		
		public var m_GridView:CellView;
		
		public var m_WallView:WallView;
		
		public function GridNavigationView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if(m_CreateView == null)
			{
				m_CreateView = new CreateView;
			}
			
			if(m_PlayView == null)
			{
				m_PlayView = new PlayView;
				m_PlayView.x = this.width - m_PlayView.width - 4;
				m_PlayView.y = 28;
			}
			
			if(m_SetView == null)
			{
				m_SetView = new SetView;
				m_SetView.x = m_PlayView.x - m_SetView.width - 4;
				m_SetView.y = 28;
			}
			
			if(m_GridView == null)
			{
				m_GridView = new CellView;
				m_GridView.x = 30;
				m_GridView.y = 60;
			}
			
			if(m_WallView == null)
			{
				m_WallView = new WallView;
				m_WallView.x = 20;
				m_WallView.y = 50;
			}
		}
	}
}