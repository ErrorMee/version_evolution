/**Created by the Morn,do not modify.*/
package game.ui.GridEditor {
	import morn.core.components.*;
	public class PlayUI extends View {
		protected static var uiXML:XML =
			<View width="420" height="840">
			  <Image skin="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="420" height="840"/>
			  <Label text="Play" x="4" y="5"/>
			</View>;
		public function PlayUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}