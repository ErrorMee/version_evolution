package Game
{
	import com.gs_extends.SyncLoaderManager;
	
	import config.base.BaseConfig;
	import config.base.BaseConfigInfo;
	import config.module.ModuleConfig;
	import config.module.ModuleConfigInfo;
	import config.service.ServiceConfig;
	
	import module.base.BaseModule;
	import module.base.ModuleContext;
	import module.base.WindowModule;
	import module.managers.CacheEnum;
	
	import org.rl_extends.DataActor;
	
	import service.InitService;
	
	import util.DateUtil;
	import util.VisualUtil;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明: 模块用到Base库里面的类  需要在这里声明一下
	 */
	public class Declare
	{
		public function Declare()
		{
			BaseConfig;
			BaseConfigInfo;
			DataActor;
			BaseModule;
			WindowModule;
			ModuleConfig;
			ModuleConfigInfo;
			ModuleContext;
			CacheEnum;
			VisualUtil;
			DateUtil;
			ServiceConfig;
		}
	}
}