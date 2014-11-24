package Game.control
{
	import Game.event.GameMainContextEvent;
	
	import module.cmd.ModuleCommand;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitNetCommand extends ModuleCommand
	{
		public function InitNetCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			trace("初始化 网络");
			dispatch(new GameMainContextEvent(GameMainContextEvent.INIT_CONTROL));
		}
	}
}