/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	public class SetItemUI extends View {
		public var m_Icon:Clip;
		public var m_IconAdd:Clip;
		protected static var uiXML:XML =
			<View width="64" height="64">
			  <Clip skin="png.comp.clip_cell" x="0" y="0" clipX="4" clipY="8" name="icon1" var="m_Icon"/>
			  <Clip skin="png.comp.clip_cell" x="0" y="0" clipX="4" clipY="8" name="icon2" var="m_IconAdd"/>
			  <Clip skin="png.comp.clip_selectline" x="0" y="0" clipY="2" name="selectBox"/>
			</View>;
		public function SetItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}