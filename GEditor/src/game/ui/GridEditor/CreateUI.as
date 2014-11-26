/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	public class CreateUI extends View {
		public var m_Close:Button;
		public var m_XNum:TextInput;
		public var m_YNum:TextInput;
		public var m_Sure:Button;
		public var m_ID:TextInput;
		public var m_UYNum:TextInput;
		protected static var uiXML:XML =
			<View width="300" height="300">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="300"/>
			  <Button skin="png.comp.btn_close" x="266" y="3" var="m_Close"/>
			  <Label text="宽度" x="85" y="90"/>
			  <TextInput text="32" skin="png.comp.textinput" x="115" y="90" restrict="0-9" width="40" var="m_XNum" maxChars="2"/>
			  <Label text="高度" x="163" y="90"/>
			  <TextInput text="32" skin="png.comp.textinput" x="193" y="90" restrict="0-9" width="40" var="m_YNum" maxChars="2"/>
			  <Label text="Create" x="4" y="3"/>
			  <Button label="确定" skin="png.comp.button" x="112.5" y="247" var="m_Sure"/>
			  <Label text="ID" x="118" y="50"/>
			  <TextInput text="10000" skin="png.comp.textinput" x="138" y="50" restrict="0-9" width="50" var="m_ID" maxChars="5"/>
			  <Label text="有效起始高度" x="93" y="120"/>
			  <TextInput text="0" skin="png.comp.textinput" x="173" y="120" restrict="0-9" width="40" var="m_UYNum" maxChars="2"/>
			</View>;
		public function CreateUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}