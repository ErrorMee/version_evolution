package Editor.main
{
	
	import Editor.main.command.InitConfigCommand;
	import Editor.main.command.InitMediatorCommand;
	import Editor.main.command.InitModelCommand;
	
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
			
			mediatorMap.mapView(MainView,MainMediator);
			
			mapCommand();
			
			dispatchEvent(new MainContextEvent(MainContextEvent.INIT_CONFIG));
		}
		
		private function mapCommand():void
		{
			commandMap.mapEvent(MainContextEvent.INIT_CONFIG, 		InitConfigCommand, MainContextEvent, true);
			commandMap.mapEvent(MainContextEvent.INIT_MODEL, 		InitModelCommand, MainContextEvent, true);
			commandMap.mapEvent(MainContextEvent.INIT_MEDIATOR, 	InitMediatorCommand, MainContextEvent, true);
		}
	}
}