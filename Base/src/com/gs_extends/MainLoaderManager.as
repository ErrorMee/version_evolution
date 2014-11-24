package com.gs_extends
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.data.SWFLoaderVars;
	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import org.robotlegs.core.IInjector;
	
	import structure.EnumVo;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public final class MainLoaderManager
	{
		public static var MAIN_DOMAIN:ApplicationDomain;
		public static var MAIN_INJECTOR:IInjector;
		
		private static var g_Instance:MainLoaderManager;
		
		/**主队列*/
		public var m_MainQueue:LoaderMax;
		
		public static const TEMP_QUEUE_NAME:String = "temp_queue_";
		public static var TEMP_QUEUE_NUM:int = 0;
		
		public function createLoader(loaderType:EnumVo,url:String,queue:LoaderMax = null):LoaderItem
		{
			if(queue == null)
			{
				queue = m_MainQueue;
			}
			var loader:LoaderItem;
			switch(loaderType)
			{
				case LoaderTypeEnum.SWF_LOADER:
					loader = queue.append(new SWFLoader(url,new SWFLoaderVars().autoPlay(false))) as LoaderItem;
					break;
				case LoaderTypeEnum.RSL_LOADER:
					var context:LoaderContext = new LoaderContext();
					context.applicationDomain = MAIN_DOMAIN;
					loader = queue.append(new SWFLoader(url, new SWFLoaderVars().autoPlay(false).context(context))
					) as LoaderItem;
					break;
				case LoaderTypeEnum.XML_LOADER:
					loader = queue.append( new XMLLoader(url) ) as LoaderItem;
					break;
				case LoaderTypeEnum.IMAGE_LOADER:
					loader = queue.append( new ImageLoader(url) ) as LoaderItem;
					break;
			}
			return loader;
		}
		
		public function createQueue():LoaderMax
		{
			TEMP_QUEUE_NUM ++;
			var tempQueue:LoaderMax = new LoaderMax(new LoaderMaxVars().name(TEMP_QUEUE_NAME + TEMP_QUEUE_NUM));
			m_MainQueue.prepend(tempQueue);
			return tempQueue;
		}
		
		public function unLoadSwf(url:String):Boolean
		{
			var loader:SWFLoader = m_MainQueue.getLoader(url) as SWFLoader;
			if(loader)
			{
				m_MainQueue.remove(loader);
				loader.pause();
				loader.unload();
				loader.dispose(true);
				loader = null;
				return true;
			}
			return false;
		}
		
		public function hasDefinition(name:String):Boolean
		{
			return ApplicationDomain.currentDomain.hasDefinition(name);
		}
		
		/**
		 * 获取本域类定义
		 */
		public function getClassByName(name:String):Class
		{
			if(hasDefinition(name)) return ApplicationDomain.currentDomain.getDefinition(name) as Class; 
			return null;
		}	
		
		public function MainLoaderManager(enforcer:SingletonEnforcer)
		{
			if(!enforcer) throw new Error("singletonEnforcer");
			enforcer = null;
			
			m_MainQueue = new LoaderMax(
				new LoaderMaxVars().name("main_queue").onProgress(progressHandler).onComplete(completeHandler).onError(errorHandler));
		}
		
		public static function GetInstance():MainLoaderManager
		{
			return g_Instance || (g_Instance = new MainLoaderManager(new SingletonEnforcer()));
		}
		
		private function progressHandler(event:LoaderEvent):void 
		{
//			trace("progress: " + event.target.progress);
		}
		
		private function completeHandler(event:LoaderEvent):void 
		{
//			trace(event.target + " is complete!");
		}
		
		private function errorHandler(event:LoaderEvent):void 
		{
			trace("error occured with " + event.target + ": " + event.text);
		}
	}
}
class SingletonEnforcer {}