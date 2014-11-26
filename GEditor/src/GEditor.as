package 
{
	import Editor.main.MainContext;
	import Editor.main.MainView;
	import Editor.main.NavigationView;
	
	import com.gs_extends.MainLoaderManager;
	
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import morn.App;
	import morn.core.handlers.Handler;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	[SWF(width="1600",height="900",frameRate="60",backgroundColor="0x24211C")]
	public class GEditor extends Sprite
	{
		private var m_MainContext:MainContext;
		
		public function GEditor()
		{
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf"],new Handler(loadMornAssetsComplete));
		}
		
		private function loadMornAssetsComplete():void
		{
			MainLoaderManager.MAIN_DOMAIN = ApplicationDomain.currentDomain;
			
			m_MainContext = new MainContext(this);
			m_MainContext.startup();	
			addChild(new MainView);
		}
	}
}