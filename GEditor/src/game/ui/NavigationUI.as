/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class NavigationUI extends View {
		public var m_Tab:Tab;
		protected static var uiXML:XML =
			<View width="1260" height="860">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="1260" height="860"/>
			  <Tab labels="label1,label2" skin="png.comp.tab" x="3" y="0" var="m_Tab"/>
			</View>;
		public function NavigationUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}