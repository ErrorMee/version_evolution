package module.managers
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import module.interfaces.ILayerManager;
	
	import structure.EnumVo;
	import structure.HashMap;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LayerManager implements ILayerManager
	{
		private var m_ContextView:DisplayObjectContainer;
		
		private var m_Layers:HashMap = new HashMap;
		
		public function LayerManager()
		{
			if(null != g_Instance) return;
			g_Instance = this;
		}
		private static var g_Instance:LayerManager;
		public static function GetInstance():LayerManager
		{
			return g_Instance;
		}
		
		public function setup(contextView:DisplayObjectContainer):void
		{
			m_ContextView = contextView;
			if(contextView == null)
			{
				trace("LayerManager 启动失败 contextView 不可为空");
				return;
			}
			
			LayerEnum.LAYERS.sort(EnumVo.sortOnValue);
			
			var i:int;
			for(i = 0;i<LayerEnum.LAYERS.length;i++)
			{
				var layer:EnumVo = LayerEnum.LAYERS[i];
				setLayer(layer.m_Name);
			}
		}
		
		private function setLayer(type:String):void
		{
			var layer:Sprite = new Sprite;
			layer.mouseEnabled = false;
			m_ContextView.addChild(layer);
			m_Layers.put(type,layer);
		}
		
		public function getLayer(type:String):DisplayObjectContainer
		{
			return m_Layers.get(type) as DisplayObjectContainer;
		}
	}
}