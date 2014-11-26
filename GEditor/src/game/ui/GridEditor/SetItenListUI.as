/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	import game.ui.GridEditor.SetItemUI;
	public class SetItenListUI extends View {
		public var m_List:List;
		protected static var uiXML:XML =
			<View width="64" height="64">
			  <List repeatX="7" repeatY="12" var="m_List">
			    <SetItem x="0" y="0" name="render" runtime="game.ui.GridEditor.SetItemUI"/>
			  </List>
			</View>;
		public function SetItenListUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.GridEditor.SetItemUI"] = SetItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}