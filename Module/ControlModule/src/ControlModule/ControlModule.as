package ControlModule
{
	import ControlModule.view.ControlView;
	
	import flash.system.ApplicationDomain;
	
	import module.base.BaseModule;
	import module.managers.LayerEnum;
	
	import org.robotlegs.core.IInjector;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明: control模块主要负责项目的模块管理 性能分析 运行日志等等
	 */
	public class ControlModule extends BaseModule
	{
		public function ControlModule()
		{
			super();
		}
		
		override protected function onStartUp():void
		{
			initModule(ControlView,ControlContext,ApplicationDomain.currentDomain,LayerEnum.LAYER_CONTROL);
		}
	}
}