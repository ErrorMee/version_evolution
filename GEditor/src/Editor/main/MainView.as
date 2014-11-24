package Editor.main
{
	import flash.display.Sprite;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class MainView extends Sprite
	{
		public var m_Navigation:NavigationView;
		
		public function MainView()
		{
			m_Navigation = new NavigationView;
			addChild(m_Navigation);
		}
	}
}