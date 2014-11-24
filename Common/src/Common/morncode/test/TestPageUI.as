/**Created by the Morn,do not modify.*/
package Common.morncode.test {
	import morn.core.components.*;
	public class TestPageUI extends Dialog {
		public function TestPageUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("test/TestPage.xml");
		}
	}
}