package ControlModule.view
{
	import Common.config.common.GameStartConfig;
	
	import com.gs_extends.MainLoaderManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import util.VisualUtil;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class Profiling extends Sprite
	{
		public static const M_COEFF:Number = 0.000000954;
		
		private var m_Text:TextField;
		private var m_StyleSheet:StyleSheet;
		private var m_Xml:XML;
		
		private var m_MemMax:Number;

		private var m_RecordTime:uint;
		private var m_CrtTime:uint;
		private var fps:uint;
		
		private var m_FpsCount:uint;
		
		public function Profiling()
		{
			m_Xml = <xml></xml>;
			
			mouseEnabled = false;
			mouseChildren = false;
			graphics.beginFill(0x000033);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
			
			m_Text = new TextField;
			m_Text.x = 5;
			m_Text.width = 90;
			m_Text.height = 100;
			m_Text.condenseWhite = true;
			m_Text.selectable = false;
			m_Text.mouseEnabled = false;
			
			m_StyleSheet = new StyleSheet;
			m_StyleSheet.setStyle("xml",{fontSize:"11px",leading:"-1px"});
			m_StyleSheet.setStyle("cfps",{color:"#ffff00"});
			m_StyleSheet.setStyle("memc",{color:"#00ffff"});
			m_StyleSheet.setStyle("memm",{color:"#ff0070"});
			m_StyleSheet.setStyle("cnum",{color:"#ff7256"});
			m_StyleSheet.setStyle("load",{color:"#836fff"});
			m_StyleSheet.setStyle("version",{color:"#f4a460"});
			m_StyleSheet.setStyle("test",{color:"#eee5de"});
			m_Text.styleSheet = m_StyleSheet;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(m_Text);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			m_CrtTime = getTimer();
			
			if( m_CrtTime - 1000 > m_RecordTime )
			{
				m_RecordTime = m_CrtTime;
				
				var mem:Number = Number((System.totalMemory * M_COEFF).toFixed(1));
				m_MemMax = m_MemMax > mem ? m_MemMax : mem;
				
				m_Xml.cfps 		= "C    FPS: " + fps + "/" + stage.frameRate;
				m_Xml.memc 		= "MEM: " + mem + "m";
				m_Xml.memm	 	= "MAX: " + m_MemMax + "m";
				m_Xml.cnum		= "CELL: " + VisualUtil.getDisplayNum(stage);
				m_Xml.load   	= "Load: " + Number((MainLoaderManager.GetInstance().m_MainQueue.bytesLoaded * M_COEFF).toFixed(1)) 
					+ "/" + Number((MainLoaderManager.GetInstance().m_MainQueue.bytesTotal * M_COEFF).toFixed(1)) + "m";
				m_Xml.version	= "V: " + GameStartConfig.GetInstance().m_GameVersion;
				m_Xml.test		= "T: " + "";
				fps = 0;
				
				m_Text.htmlText = m_Xml;
			}
			fps++;
		}
		
		private function destroy(e:Event):void
		{
			VisualUtil.removeAllChild(this);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			removeEventListener(Event.ENTER_FRAME, update);
		}
	}
}

