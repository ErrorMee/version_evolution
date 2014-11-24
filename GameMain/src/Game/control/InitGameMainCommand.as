package Game.control
{
	import Game.GameMainMediator;
	import Game.event.GameMainContextEvent;
	
	import com.gs_extends.MainLoaderManager;
	
	import flash.system.ApplicationDomain;
	
	import module.cmd.ModuleCommand;
	import module.managers.ModuleManager;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitGameMainCommand extends ModuleCommand
	{
		public function InitGameMainCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			mediatorMap.mapView(GameMain,GameMainMediator);
			mediatorMap.createMediator(contextView);
			dispatch(new GameMainContextEvent(GameMainContextEvent.INIT_NET));
		}
	}
}