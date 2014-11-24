package 
{
	import Game.Declare;
	import Game.MainContext;
	
	import com.gs_extends.MainLoaderManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:文档类
	 */
	[SWF(width="1250",height="650",frameRate="60",backgroundColor="0x1E1E1E")]
	public class GameMain extends Sprite
	{
		private var m_MainContext:MainContext;
		
		public function GameMain()
		{
			if(stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Declare;
			Security.allowDomain("*");
			
			initStage();
			initMVC();
		}
		
		private function initStage():void
		{			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
		}
		
		private function initMVC():void
		{
			if(null == MainLoaderManager.MAIN_DOMAIN)
			{
				MainLoaderManager.MAIN_DOMAIN = ApplicationDomain.currentDomain;
			}
			
			m_MainContext = new MainContext(this);
			m_MainContext.startup();	
		}
	}
}