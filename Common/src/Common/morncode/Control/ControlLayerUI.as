/**Created by the Morn,do not modify.*/
package Common.morncode.Control {
	import morn.core.components.*;
	public class ControlLayerUI extends View {
		public var m_LogText:TextArea;
		public var m_SaveLog:Button;
		public var m_FunList:List;
		public function ControlLayerUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("Control/ControlLayer.xml");
		}
	}
}