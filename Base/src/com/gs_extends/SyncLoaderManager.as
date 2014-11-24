package com.gs_extends
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import structure.EnumVo;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SyncLoaderManager
	{
		private static var g_Instance:SyncLoaderManager;
		/**
		 * 同步队列
		 * 该“同步”指游戏进程  比如说游戏初始化loading的所有加载算是一个同步 所有的都完成了才进游戏界面  
		 * 战斗的进入 模块的打开都可以使用该队列
		 * 注意该队列不可交叉使用 那样会失去同步的意义
		 */
		public var m_SyncQueue:LoaderMax;
		
		public function SyncLoaderManager(enforcer:SingletonEnforcer)
		{
			if(!enforcer) throw new Error("singletonEnforcer");
			enforcer = null;
			
			m_SyncQueue = new LoaderMax(
				new LoaderMaxVars().name("sync_queue").onProgress(progressHandler).onComplete(completeHandler).onError(errorHandler));
		}
		
		////////////////////////////// public func //////////////////////////////
		
		public function createLoader(loaderType:EnumVo,url:String):LoaderItem
		{
			var loader:LoaderItem;
			switch(loaderType)
			{
				case LoaderTypeEnum.SWF_LOADER:
					loader = m_SyncQueue.append( new SWFLoader(url, {autoPlay:false}) ) as LoaderItem;
					break;
			}
			return loader;
		}
		
		public static function GetInstance():SyncLoaderManager
		{
			return g_Instance || (g_Instance = new SyncLoaderManager(new SingletonEnforcer()));
		}
		
		private function progressHandler(event:LoaderEvent):void 
		{
			trace("progress: " + event.target.progress);
		}
		
		private function completeHandler(event:LoaderEvent):void 
		{
			trace(event.target + " is complete!");
		}
		
		private function errorHandler(event:LoaderEvent):void 
		{
			trace("error occured with " + event.target + ": " + event.text);
		}
	}
}
class SingletonEnforcer {}