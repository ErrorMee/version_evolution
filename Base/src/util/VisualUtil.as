package util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class VisualUtil
	{
		public static function removeAllChild(object:DisplayObject):void
		{
			if(object == null)
			{
				return;
			}
			if(object is DisplayObjectContainer)
			{
				var objectCont:DisplayObjectContainer = object as DisplayObjectContainer;
				while(objectCont.numChildren > 0)
				{
					objectCont.removeChildAt(0);
				}
			}
		}
		
		public static function removeFromParent(object:DisplayObject):void
		{
			if(object == null)
			{
				return;
			}
			if(object.parent)
			{
				object.parent.removeChild(object);
			}
		}
		
		public static function getDisplayNum(container:DisplayObjectContainer):uint 
		{
			if(container)
			{
				var num:uint = container.numChildren;
				var len:uint = num; 
				for(var i:int = 0; i < len; i++)
				{
					var display:DisplayObject = container.getChildAt(i);
					if(display is DisplayObjectContainer)
					{
						num += getDisplayNum(display as DisplayObjectContainer);
					}
				}
				return num;
			}
			return 0;
		}
		
		public static function setTextFocus(text:TextField,selectAll:Boolean = true):void
		{
			if(text && text.stage)
			{
				text.stage.focus = text;
				if(selectAll)
				{
					text.setSelection(0,text.length);
				}
			}
		}
		
		private static function goto(mc:DisplayObject, frame:uint = 1,mcPlayFunName:String = "gotoAndStop"):void 
		{ 
			if(mc == null || !(mc is DisplayObjectContainer)) 
			{ 
				return;
			} 
			var mcContainer:DisplayObjectContainer = mc as DisplayObjectContainer;
			
			if(mcContainer is MovieClip)
			{
				frame > 0 ? mc[mcPlayFunName](frame) : mc[mcPlayFunName](); 
			}
			
			if (mcContainer.numChildren > 0) 
			{ 
				for (var i:int = 0; i < mcContainer.numChildren; i++ ) 
				{ 
					if (mcContainer.getChildAt(i) as DisplayObjectContainer) 
					{ 
						goto(mcContainer.getChildAt(i), frame, mcPlayFunName); 
					} 
				} 
			} 
		}
		
		public static function start_mc(mc:DisplayObject = null):void
		{
			goto(mc,1,"gotoAndPlay");
		}
		
		public static function stop_mc(mc:DisplayObject = null):void
		{
			goto(mc,1,"gotoAndStop");
		}
		
		public static function pause_mc(mc:DisplayObject = null):void
		{
			goto(mc,0,"stop");
		}
		
		public static function continue_mc(mc:DisplayObject = null):void
		{
			goto(mc,0,"play");
		}
	}
}