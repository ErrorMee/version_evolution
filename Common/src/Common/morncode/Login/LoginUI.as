/**Created by the Morn,do not modify.*/
package Common.morncode.Login {
	import morn.core.components.*;
	public class LoginUI extends View {
		public var m_BG:Image;
		public var m_User:TextInput;
		public var m_Title:Label;
		public var m_ServerList:List;
		public function LoginUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("Login/Login.xml");
		}
	}
}