/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	import game.ui.GridEditor.SetItenListUI;
	import game.ui.GridEditor.WallItemUI;
	public class SetUI extends View {
		public var m_BrushType:TextInput;
		public var m_Random:Button;
		public var m_Default:Button;
		public var m_List:SetItenListUI;
		public var m_All:Button;
		public var m_ComboBox:ComboBox;
		public var m_WallList:List;
		protected static var uiXML:XML =
			<View width="460" height="600">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="460" height="750"/>
			  <Label text="设置" x="216" y="4"/>
			  <Label text="类型" x="10" y="65"/>
			  <TextInput text="四字名字" skin="png.comp.textinput" x="42" y="65" maxChars="2" width="100" var="m_BrushType" height="22"/>
			  <Button label="随机" skin="png.comp.button" x="252.5" y="64" var="m_Random" width="40"/>
			  <Button label="默认" skin="png.comp.button" x="202.5" y="64" var="m_Default" width="40"/>
			  <SetItenList x="6" y="91" var="m_List" runtime="game.ui.GridEditor.SetItenListUI"/>
			  <Button label="全部" skin="png.comp.button" x="152" y="64" var="m_All" width="40"/>
			  <ComboBox labels="格子,墙壁" skin="png.comp.combobox" x="9" y="33" var="m_ComboBox" selectedIndex="0"/>
			  <List x="38" y="96" repeatX="6" repeatY="6" spaceX="2" spaceY="10" var="m_WallList">
			    <WallItem name="render" runtime="game.ui.GridEditor.WallItemUI"/>
			  </List>
			</View>;
		public function SetUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.GridEditor.SetItenListUI"] = SetItenListUI;
			viewClassMap["game.ui.GridEditor.WallItemUI"] = WallItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}