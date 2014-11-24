/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	public class WallItemUI extends View {
		public var m_Icon:Clip;
		protected static var uiXML:XML =
			<View width="66" height="10">
			  <Clip skin="png.comp.clip_wall" x="-32" y="-4" clipY="8" var="m_Icon" clipX="1"/>
			  <Clip skin="png.comp.clip_selectline" x="-33" y="-5" clipY="2" name="selectBox" sizeGrid="2,2,2,2" width="66" height="10"/>
			</View>;
		public function WallItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}