package SpineModule.view
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.gs_extends.LoaderTypeEnum;
	
	import flash.display.Bitmap;
	
	import module.mediator.ModuleMediator;
	
	import spine.Event;
	import spine.SkeletonData;
	import spine.SkeletonJson;
	import spine.animation.AnimationStateData;
	import spine.atlas.Atlas;
	import spine.attachments.AtlasAttachmentLoader;
	import spine.flash.FlashTextureLoader;
	import spine.flash.SkeletonAnimation;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SpineMediator extends ModuleMediator
	{
		public function SpineMediator()
		{
			super();
		}
		
		private function get view():SpineView
		{
			return getViewComponent() as SpineView;
		}
		
		override protected function initView():void
		{
			view.x = (view.stage.stageWidth - view.width) >> 1;
			view.y = (view.stage.stageHeight - view.height) >> 1;
			
			spineLoad();
		}
		
		private function spineLoad():void
		{
			var tempQueue:LoaderMax = i_MainLoaderManager.createQueue();
			i_ResourceManager.loadResource(LoaderTypeEnum.XML_LOADER,"SpineAtlas","spineboy",tempQueue);
			i_ResourceManager.loadResource(LoaderTypeEnum.XML_LOADER,"SpineJson","spineboy",tempQueue);
			i_ResourceManager.loadResource(LoaderTypeEnum.IMAGE_LOADER,"SpinePng","spineboy",tempQueue);
			tempQueue.addEventListener(LoaderEvent.COMPLETE,onSpineLoad);
			tempQueue.load();
		}
		
		private function onSpineLoad(e:LoaderEvent):void
		{
			(e.currentTarget as LoaderMax).removeEventListener(LoaderEvent.COMPLETE,onSpineLoad);
			m_SpineboyAtlas = i_ResourceManager.getLoaderContent("SpineAtlas","spineboy").toString();
			m_SpineboyJson = i_ResourceManager.getLoaderContent("SpineJson","spineboy").toString();
			m_SpineboyAtlasTexture = i_ResourceManager.getRawContent("SpinePng","spineboy") as Bitmap;
			initSpine();
		}
		
		/**
		 * 贴图配置
		 */
		private var m_SpineboyAtlas:String;
		/**
		 * 贴图素材
		 */
		private var m_SpineboyAtlasTexture:Bitmap;
		/**
		 * 骨骼动画配置
		 */
		private var m_SpineboyJson:String;
		
		private var skeleton:SkeletonAnimation;
		
		/**
		 * FlashTextureLoader
		 * Atlas
		 * AtlasAttachmentLoader
		 * SkeletonJson
		 * AnimationStateData
		 * SkeletonAnimation
		 */
		private function initSpine():void
		{
			var atlas:Atlas = new Atlas(m_SpineboyAtlas, new FlashTextureLoader(m_SpineboyAtlasTexture));
			var json:SkeletonJson = new SkeletonJson(new AtlasAttachmentLoader(atlas));
			json.scale = 0.5;
			var skeletonData:SkeletonData = json.readSkeletonData(m_SpineboyJson);
			
			var stateData:AnimationStateData = new AnimationStateData(skeletonData);
			stateData.setMixByName("walk", "jump", 0.2);
			stateData.setMixByName("jump", "run", 0.4);
			stateData.setMixByName("jump", "jump", 0.2);
			
			skeleton = new SkeletonAnimation(skeletonData, stateData);
			skeleton.x = 100;
			skeleton.y = 600;
			
			skeleton.state.onStart.add(function (trackIndex:int) : void {
				trace(trackIndex + " start: " + skeleton.state.getCurrent(trackIndex));
			});
			skeleton.state.onEnd.add(function (trackIndex:int) : void {
				trace(trackIndex + " end: " + skeleton.state.getCurrent(trackIndex));
			});
			skeleton.state.onComplete.add(function (trackIndex:int, count:int) : void {
				trace(trackIndex + " complete: " + skeleton.state.getCurrent(trackIndex) + ", " + count);
			});
			skeleton.state.onEvent.add(function (trackIndex:int, event:Event) : void {
				trace(trackIndex + " event: " + skeleton.state.getCurrent(trackIndex) + ", "
					+ event.data.name + ": " + event.intValue + ", " + event.floatValue + ", " + event.stringValue);
			});
			
			skeleton.state.setAnimationByName(0, "walk", true);
			skeleton.state.addAnimationByName(0, "jump", false, 3);
			skeleton.state.addAnimationByName(0, "run", true, 0);
			
			view.addChild(skeleton);
		}
	}
}

