/**Created by the Morn,do not modify.*/
package Common.morncode.Control {
	import morn.core.components.*;
	import Common.morncode.Control.ControlLayerUI;
	public class ControlUI extends View {
		public var m_Check:CheckBox;
		public var m_ControlLayer:ControlLayerUI;
		public function ControlUI(){}
		override protected function createChildren():void {
			viewClassMap["Common.morncode.Control.ControlLayerUI"] = ControlLayerUI;
			super.createChildren();
			loadUI("Control/Control.xml");
		}
	}
}