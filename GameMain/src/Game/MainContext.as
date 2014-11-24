package Game
{
	import Game.control.InitActorCommand;
	import Game.control.InitCommonCommand;
	import Game.control.InitConfigCommand;
	import Game.control.InitControlCommand;
	import Game.control.InitGameMainCommand;
	import Game.control.InitNetCommand;
	import Game.event.GameMainContextEvent;
	
	import com.gs_extends.MainLoaderManager;
	
	import flash.display.DisplayObjectContainer;
	
	import module.event.ModuleEventDispatcher;
	
	import org.robotlegs.mvcs.Context;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class MainContext extends Context
	{
		public function MainContext(contextView:DisplayObjectContainer=null)
		{
			super(contextView, false);
		}
		
		override public function startup():void 
		{
			if(null == MainLoaderManager.MAIN_INJECTOR)
			{
				MainLoaderManager.MAIN_INJECTOR = injector;
			}
			/**
			 * 全局模块事件中心
			 */
			var moduleDispatcher:ModuleEventDispatcher = new ModuleEventDispatcher(this);
			injector.mapValue(ModuleEventDispatcher, moduleDispatcher);
			
			mapCommand();
			dispatchEvent(new GameMainContextEvent(GameMainContextEvent.INIT_COMMON));
		}
		
		private function mapCommand():void
		{
			commandMap.mapEvent(GameMainContextEvent.INIT_COMMON, 		InitCommonCommand, GameMainContextEvent, true);
			commandMap.mapEvent(GameMainContextEvent.INIT_CONFIG, 		InitConfigCommand, GameMainContextEvent, true);
			commandMap.mapEvent(GameMainContextEvent.INIT_ACTOR, 		InitActorCommand, GameMainContextEvent, true);
			commandMap.mapEvent(GameMainContextEvent.INIT_GAME_MAIN, 	InitGameMainCommand, GameMainContextEvent, true);
			commandMap.mapEvent(GameMainContextEvent.INIT_NET, 			InitNetCommand, GameMainContextEvent, true);
			commandMap.mapEvent(GameMainContextEvent.INIT_CONTROL,		InitControlCommand,GameMainContextEvent,true);
		}
		
	}
}