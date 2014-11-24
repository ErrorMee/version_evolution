package Editor.main.command
{
	import Editor.main.MainContextEvent;
	import Editor.module.GridEditorModule.model.GridModel;
	
	import module.cmd.ModuleCommand;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitModelCommand extends ModuleCommand
	{
		public function InitModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			injector.mapSingleton(GridModel);
			
			dispatch(new MainContextEvent(MainContextEvent.INIT_MEDIATOR));
		}
	}
}