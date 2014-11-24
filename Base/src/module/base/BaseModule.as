package module.base
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import module.interfaces.IModule;
	import module.interfaces.IModuleContext;
	import module.managers.LayerEnum;
	import module.managers.LayerManager;
	
	import org.robotlegs.core.IInjector;
	
	import structure.EnumVo;
	
	import util.VisualUtil;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class BaseModule implements IModule
	{
		protected var m_ParentContainer:DisplayObjectContainer;
		protected var m_ModuleView:Sprite;
		protected var m_ModuleContext:IModuleContext;
		
		private var m_StartUpParam:Object;
		private var m_UpdateParam:Object;
		private var m_Name:String;
		private var m_IsClosed:Boolean = true;
		
		protected var m_ParentInjector:IInjector;
		
		public function BaseModule()
		{
		}
		
		public function startUp(injector:IInjector=null, startUpParameter:Object=null):void
		{
			m_ParentInjector = injector;	
			
			m_IsClosed = true;
			m_StartUpParam = startUpParameter;
			
			onStartUp();
		}
		
		public function getStartUpParam():Object
		{
			return m_StartUpParam;
		}
		
		public function update(param:Object=null):void
		{
			m_IsClosed = false;
			m_UpdateParam = param;
		}
		
		public function getUpdateParam():Object
		{
			return m_UpdateParam;
		}
		
		public function close():void
		{
			m_IsClosed = true;
			
			onClose();
		}
		
		public function isClosed():Boolean
		{
			return m_IsClosed;
		}
		
		public function getModuleView():DisplayObject
		{
			return null;
		}
		
		public function setName(name:String):void
		{
			m_Name = name;
		}
		
		public function getName():String
		{
			return m_Name;
		}
		
		public function clear():void
		{
			m_StartUpParam = null;
			m_UpdateParam = null;
		}
		
		public function dispose():void
		{
			clear();
			if(m_ModuleContext) 
			{
				m_ModuleContext.dispose();
				m_ModuleContext = null;
			}
			disposeView();
			m_ParentInjector = null;
		}
		
		protected function disposeView():void
		{
			VisualUtil.stop_mc(m_ModuleView);
			VisualUtil.removeAllChild(m_ModuleView);
			VisualUtil.removeFromParent(m_ModuleView);
			
			m_ParentContainer = null;
			m_ModuleView = null;
		}
		
		protected function onStartUp():void {}
		protected function onClose():void
		{
			VisualUtil.removeFromParent(m_ModuleView);
		}
		
		protected function initModule(viewCls:Class,contextCls:Class,domain:ApplicationDomain = null,layerEnum:EnumVo = null):void
		{
			if(layerEnum == null)
			{
				layerEnum = LayerEnum.LAYER_UI;
			}
			m_ModuleView = new viewCls;
			m_ModuleContext = new contextCls(m_ModuleView,m_ParentInjector,domain);
			m_ParentContainer = LayerManager.GetInstance().getLayer(layerEnum.m_Name);
			m_ParentContainer.addChild(m_ModuleView);
		}
	}
}