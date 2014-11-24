package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GameShell extends Sprite
	{
		private var m_LoaderInfoParameters:Object;
		private var m_VersionLoader:URLLoader;
		private var m_VersionDic:Dictionary;
		private var m_CDNRootPath:String = "./";
		
		public function GameShell()
		{
			m_LoaderInfoParameters = this.root.loaderInfo.parameters;
			if(stage)
			{
				init();
			}
			else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(evt:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			initMenu();
			loadVersion();
		}
		
		private function initMenu():void
		{
			this.stage.showDefaultContextMenu = false;
		}
		
		private function loadVersion():void
		{
			m_VersionLoader = new URLLoader;
			m_VersionLoader.dataFormat = URLLoaderDataFormat.BINARY;
			m_VersionLoader.addEventListener(Event.COMPLETE,completeVersion);
			m_VersionLoader.addEventListener(IOErrorEvent.IO_ERROR,onVersionError);
			m_VersionLoader.load(new URLRequest(m_CDNRootPath + "asset/version.dat?=" + Math.round(Math.random() * 1000000)));
		}
		
		private function completeVersion(e:Event):void
		{
			m_VersionLoader.removeEventListener(Event.COMPLETE,completeVersion);
			m_VersionLoader.removeEventListener(IOErrorEvent.IO_ERROR,onVersionError);
			
			var versionData:ByteArray = m_VersionLoader.data as ByteArray;
			if(versionData)
			{
				var fileCount:int = versionData.readShort();
				var ba:ByteArray = new ByteArray();
				versionData.readBytes( ba );
				ba.uncompress();
				var versionCodeCount:int;
				var keyCount:int;
				m_VersionDic = new Dictionary;
				while ( 0 < fileCount-- )
				{
					keyCount = ba.readShort();
					versionCodeCount = ba.readShort();
					var keyStr:String = ba.readUTFBytes( keyCount );
					m_VersionDic[keyStr] = [ba.readUTFBytes( versionCodeCount ), ba.readInt()];
				}
			}
			initMLoad();
		}
		
		private function onVersionError(e:Event = null):void
		{
			m_VersionLoader.removeEventListener(Event.COMPLETE,completeVersion);
			m_VersionLoader.removeEventListener(IOErrorEvent.IO_ERROR,onVersionError);
			
			initMLoad();
		}
		
		private function initMLoad():void
		{
//			m_Loading = new Loader;
//			m_Loading.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
//			m_Loading.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
//			
//			var context:LoaderContext = new LoaderContext();
//			context.applicationDomain = new ApplicationDomain();    //这个是关键
//			context.checkPolicyFile = true;
//			context.securityDomain = SecurityDomain.currentDomain;
//			
//			var loadUIUrl:String = m_CDNRootPath + "asset/resource/mainload/MainLoadUI.swf";
//			if(VersionUtil.getVersionUrl(m_VersionDic,loadUIUrl,m_CDNRootPath))
//			{
//				m_Loading.load(new URLRequest(VersionUtil.getVersionUrl(m_VersionDic,loadUIUrl,m_CDNRootPath)),context);
//			}else{
//				m_Loading.load(new URLRequest(loadUIUrl + "?=" + Math.round(Math.random() * 10000)),context);
//			}
		}
	}
}