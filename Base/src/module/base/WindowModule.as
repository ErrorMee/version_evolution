package module.base
{
	import flash.system.ApplicationDomain;
	
	import module.managers.LayerEnum;
	
	import structure.EnumVo;
	

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:窗口模块 所在层：WINDOW
	 */
	public class WindowModule extends BaseModule
	{
		public function WindowModule()
		{
			super();
		}
		
		override protected function initModule(viewCls:Class,contextCls:Class,domain:ApplicationDomain = null,layerEnum:EnumVo = null):void
		{
			super.initModule(viewCls,contextCls,domain,LayerEnum.LAYER_WINDOW);
		}
	}
}