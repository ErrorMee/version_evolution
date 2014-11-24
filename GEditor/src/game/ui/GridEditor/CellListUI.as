/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	import game.ui.GridEditor.CellUI;
	public class CellListUI extends View {
		public var m_List:List;
		protected static var uiXML:XML =
			<View width="600" height="400" name="render">
			  <List repeatX="4" repeatY="4" spaceX="10" spaceY="10" var="m_List">
			    <Cell x="0" y="0" name="render" runtime="game.ui.GridEditor.CellUI"/>
			  </List>
			</View>;
		public function CellListUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.GridEditor.CellUI"] = CellUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}