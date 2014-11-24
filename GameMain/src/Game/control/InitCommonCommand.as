package Game.control
{
	import Game.config.GameMainConfig;
	import Game.event.GameMainContextEvent;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderItem;
	import com.gs_extends.LoaderTypeEnum;
	import com.gs_extends.MainLoaderManager;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	import module.cmd.ModuleCommand;
	
	import morn.App;
	import morn.Config;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:初始化common库
	 */
	public class InitCommonCommand extends ModuleCommand
	{
		public function InitCommonCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var loaderItem:LoaderItem = MainLoaderManager.GetInstance().createLoader(LoaderTypeEnum.RSL_LOADER,GameMainConfig.COMMON_PATH);
			loaderItem.addEventListener(LoaderEvent.COMPLETE,onLoadCommonComplete);
			loaderItem.addEventListener(LoaderEvent.IO_ERROR,onLoadCommonError);
			loaderItem.load();
		}
		
		private function onLoadCommonComplete(e:LoaderEvent):void
		{
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.COMPLETE,onLoadCommonComplete);
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.IO_ERROR,onLoadCommonError);
			initMorn();
		}
		
		private function onLoadCommonError(e:LoaderEvent):void
		{
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.COMPLETE,onLoadCommonComplete);
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.IO_ERROR,onLoadCommonError);
			trace("加载common库失败");
		}
		
		private function initMorn():void
		{
			Config.uiPath = GameMainConfig.MORN_UI_CONFIG;
			Config.GAME_FPS = 60;
			App.init(contextView as Sprite);
			
			var loaderItem:LoaderItem = MainLoaderManager.GetInstance().createLoader(LoaderTypeEnum.RSL_LOADER,GameMainConfig.MORN_GLOBAL_UI_LIB);
			loaderItem.addEventListener(LoaderEvent.COMPLETE,onLoadUIComplete);
			loaderItem.addEventListener(LoaderEvent.IO_ERROR,onLoadUIError);
			loaderItem.load();
		}
		
		private function onLoadUIComplete(e:LoaderEvent):void
		{
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.COMPLETE,onLoadUIComplete);
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.IO_ERROR,onLoadUIError);
			dispatchToContext(new GameMainContextEvent(GameMainContextEvent.INIT_CONFIG));
		}
		
		private function onLoadUIError(e:LoaderEvent):void
		{
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.COMPLETE,onLoadUIComplete);
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.IO_ERROR,onLoadUIError);
			trace("加载MORN_UI共享库失败");
		}
	}
}