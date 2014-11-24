package Game
{
	import module.mediator.ModuleMediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GameMainMediator extends ModuleMediator
	{
		public function GameMainMediator()
		{
			super();
		}
		
		override protected function initView():void
		{
			trace("GameMainMediator start");
		}
	}
}