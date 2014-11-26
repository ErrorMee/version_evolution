/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	public class NavigationUI extends View {
		public var m_Create:Button;
		public var m_Open:Button;
		public var m_Save:Button;
		protected static var uiXML:XML =
			<View width="1600" height="880">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="1600" height="880"/>
			  <Button label="新建" skin="png.comp.button" x="5" y="2" var="m_Create"/>
			  <Button label="打开" skin="png.comp.button" x="85" y="2" var="m_Open"/>
			  <Button label="保存" skin="png.comp.button" x="165" y="2" var="m_Save"/>
			</View>;
		public function NavigationUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}