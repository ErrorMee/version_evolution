package Game.control
{
	import Common.config.common.GameStartConfig;
	import Common.config.common.GameStartConfigInfo;
	
	import Game.config.GameMainConfig;
	import Game.event.GameMainContextEvent;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderItem;
	import com.gs_extends.LoaderTypeEnum;
	import com.gs_extends.MainLoaderManager;
	
	import config.base.BaseConfig;
	import config.base.BaseConfigInfo;
	
	import flash.events.EventDispatcher;
	import flash.system.System;
	
	import module.cmd.ModuleCommand;
	
	import util.XMLUtil;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitConfigCommand extends ModuleCommand
	{
		public function InitConfigCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var loaderItem:LoaderItem = MainLoaderManager.GetInstance().createLoader(LoaderTypeEnum.XML_LOADER,GameMainConfig.START_CONFIG_PATH);
			loaderItem.addEventListener(LoaderEvent.COMPLETE,onLoadStartComplete);
			loaderItem.addEventListener(LoaderEvent.IO_ERROR,onLoadStartError);
			loaderItem.load();
		}
		
		private function onLoadStartError(e:LoaderEvent):void
		{
			(e.currentTarget as EventDispatcher).removeEventListener(LoaderEvent.IO_ERROR,onLoadStartError);
			trace("加载StartConfig失败");
		}
		
		private function onLoadStartComplete(e:LoaderEvent):void
		{
			trace("load StartConfig Complete");
			var xmlLoader:XMLLoader = e.currentTarget as XMLLoader;
			xmlLoader.removeEventListener(LoaderEvent.COMPLETE,onLoadStartComplete);
			xmlLoader.removeEventListener(LoaderEvent.IO_ERROR,onLoadStartError);
			
			var startXml:XML = xmlLoader.getContent(GameMainConfig.START_CONFIG_PATH);
			
			var gameStartConfig:GameStartConfig = new GameStartConfig;
			
			gameStartConfig.m_HungryZip = XMLUtil.checkPropIsTrue(startXml.hungry.@zip);
			gameStartConfig.m_HungryPath = startXml.hungry.@path;
			gameStartConfig.m_GameVersion = startXml.game.@version;
			
			gameStartConfig.parseXML(startXml.hungry[0],GameStartConfigInfo);
			
			injector.mapValue(GameStartConfig,gameStartConfig);
			
			xmlLoader.dispose(true);
			
			if(gameStartConfig.m_HungryZip)
			{
				//todo 解析压缩文件
			}else{
				loadHungryConfig();
			}
		}
		
		private function loadHungryConfig():void
		{
			var gameStartConfig:GameStartConfig = injector.getInstance(GameStartConfig);
			var gameStartConfigInfo:GameStartConfigInfo = gameStartConfig.getConfigList().shift() as GameStartConfigInfo;
			var loaderItem:LoaderItem;
			if(gameStartConfigInfo)
			{
				var ConfigCls:Class = MainLoaderManager.GetInstance().getClassByName(gameStartConfigInfo.className);
				if(ConfigCls == null)
				{
					throw new ArgumentError(gameStartConfigInfo.className + " 未定义");
					return;
				}
				
				if(gameStartConfigInfo.isXml())
				{
					loaderItem = MainLoaderManager.GetInstance().createLoader(LoaderTypeEnum.XML_LOADER,gameStartConfig.m_HungryPath + gameStartConfigInfo.id);
				}else{
					//todo 加载二进制文件
				}
				
				loaderItem.addEventListener(LoaderEvent.COMPLETE,function(e:LoaderEvent):void
				{
					loaderItem.removeEventListener(LoaderEvent.COMPLETE,arguments.callee);
					
					var configInstance:BaseConfig = new ConfigCls as BaseConfig;
					if(configInstance == null)
					{
						trace("类继承错误：" + gameStartConfigInfo.className);
						return;
					}
					
					var ConfigInfoCls:Class = MainLoaderManager.GetInstance().getClassByName(gameStartConfigInfo.className + "Info");
					if(gameStartConfigInfo.isXml())
					{
						trace("analyze XML：" + gameStartConfigInfo.className);
						var xml:XML = XML((loaderItem as XMLLoader).getContent(gameStartConfig.m_HungryPath + gameStartConfigInfo.id));
						configInstance.parseXML(xml,ConfigInfoCls,Boolean(gameStartConfigInfo.asyn));
						if(!Boolean(gameStartConfigInfo.asyn))
						{
							loaderItem.dispose(true);
						}
					}else{
						//todo 解析二进制文件
					}
					injector.mapValue(ConfigCls,configInstance);
					
					if(gameStartConfig.getConfigList().length())
					{
						loadHungryConfig();
					}else{
						dispatch(new GameMainContextEvent(GameMainContextEvent.INIT_ACTOR));
					}
				});
				
				loaderItem.load();
			}
		}
		
	}
}