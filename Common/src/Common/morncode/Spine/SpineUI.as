/**Created by the Morn,do not modify.*/
package Common.morncode.Spine {
	import morn.core.components.*;
	public class SpineUI extends View {
		public var m_BG:Image;
		public function SpineUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("Spine/Spine.xml");
		}
	}
}