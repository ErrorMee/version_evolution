package Game.control
{
	import Common.model.GameModel;
	
	import Game.event.GameMainContextEvent;
	
	import com.gs_extends.MainLoaderManager;
	
	import module.cmd.ModuleCommand;
	import module.event.ModuleEvent;
	import module.managers.CacheManager;
	import module.managers.LayerManager;
	import module.managers.ModuleManager;
	import module.managers.ResourceManager;
	
	import service.socket.SocketManager;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitActorCommand extends ModuleCommand
	{
		public function InitActorCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			initManager();
			initDataActor();
			initServiceActor();
			dispatch(new GameMainContextEvent(GameMainContextEvent.INIT_GAME_MAIN));
		}
		
		private function initManager():void
		{
			injector.mapSingleton(ModuleManager);
			
			var layerManager:LayerManager = new LayerManager;
			layerManager.setup(contextView);
			injector.mapValue(LayerManager,layerManager);
			
			injector.mapSingleton(ModuleEvent);
			
			injector.mapSingleton(CacheManager);
			
			injector.mapValue(MainLoaderManager,MainLoaderManager.GetInstance());
			
			injector.mapSingleton(ResourceManager);
			
			injector.mapSingleton(SocketManager);
		}
		
		private function initDataActor():void
		{
			injector.mapSingleton(GameModel);
		}
		
		private function initServiceActor():void
		{
			
		}
	}
}