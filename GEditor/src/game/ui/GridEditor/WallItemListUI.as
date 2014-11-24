/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	import game.ui.GridEditor.WallItemUI;
	public class WallItemListUI extends View {
		public var m_List:List;
		protected static var uiXML:XML =
			<View width="66" height="10">
			  <List repeatX="9" repeatY="17" spaceX="6" spaceY="32" var="m_List">
			    <WallItem x="0" y="0" name="render" runtime="game.ui.GridEditor.WallItemUI"/>
			  </List>
			</View>;
		public function WallItemListUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.GridEditor.WallItemUI"] = WallItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}