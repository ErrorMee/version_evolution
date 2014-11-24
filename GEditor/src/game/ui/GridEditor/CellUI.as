/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	public class CellUI extends View {
		public var m_BG:Clip;
		public var m_IconAdd:Clip;
		public var m_Value:Label;
		public var m_Pos:Label;
		protected static var uiXML:XML =
			<View width="64" height="64">
			  <Clip skin="png.comp.clip_cell" x="0" y="0" clipX="4" clipY="8" var="m_BG"/>
			  <Clip skin="png.comp.clip_cell" x="0" y="0" clipX="4" clipY="8" name="icon2" var="m_IconAdd"/>
			  <Label text="(0-0)" x="0" y="0" var="m_Value" align="left" width="64" height="24" color="0xff00ff" size="16" background="false"/>
			  <Label text="(0,0)" x="0" y="46" var="m_Pos" align="right" width="64" height="18" color="0xff00ff"/>
			  <Clip skin="png.comp.clip_selectline" x="0" y="0" clipY="2" name="selectBox"/>
			</View>;
		public function CellUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}