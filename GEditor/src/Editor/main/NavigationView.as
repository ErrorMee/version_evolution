package Editor.main
{
	import game.ui.NavigationUI;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class NavigationView extends NavigationUI
	{
		public function NavigationView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			m_Tab.dataSource = ["地格编辑"];
		}
	}
}