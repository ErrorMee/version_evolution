package LoginModule.util
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LineUtil
	{
		/**
		 * 画斑马线
		 * 
		 * @param graphics <b> Graphics</b> 
		 * @param beginPoint <b> Point </b> 
		 * @param endPoint <b> Point </b> 
		 * @param width  <b> Number </b> 斑马线的宽度
		 * @param grap  <b> Number </b> 
		 */
		static public function drawZebraStripes(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number):void
		{
			if (!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0) return;
			
			var Ox:Number = beginPoint.x;
			var Oy:Number = beginPoint.y;
			
			var totalLen:Number = Point.distance(beginPoint, endPoint);
			var currLen:Number = 0;
			var halfWidth:Number = width * .5;
			
			var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
			var radian1:Number = (radian / Math.PI * 180 + 90) / 180 * Math.PI;
			var radian2:Number = (radian / Math.PI * 180 - 90) / 180 * Math.PI;
			
			var currX:Number, currY:Number;
			var p1x:Number, p1y:Number;
			var p2x:Number, p2y:Number;
			
			while (currLen <= totalLen)
			{
				currX = Ox + Math.cos(radian) * currLen;
				currY = Oy + Math.sin(radian) * currLen;
				p1x = currX + Math.cos(radian1) * halfWidth;
				p1y = currY + Math.sin(radian1) * halfWidth;
				p2x = currX + Math.cos(radian2) * halfWidth;
				p2y = currY + Math.sin(radian2) * halfWidth;
				
				graphics.moveTo(p1x, p1y);
				graphics.lineTo(p2x, p2y);
				
				currLen += grap;
			}
		}
		
		
		/**
		 * 画虚线
		 * 
		 * @param graphics <b> Graphics</b> 
		 * @param beginPoint <b> Point </b> 
		 * @param endPoint <b> Point </b> 
		 * @param width  <b> Number </b> 虚线的长度
		 * @param grap  <b> Number </b> 
		 */
		static public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number):void
		{
			if (!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0) return;
			
			var Ox:Number = beginPoint.x;
			var Oy:Number = beginPoint.y;
			
			var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
			var totalLen:Number = Point.distance(beginPoint, endPoint);
			var currLen:Number = 0;
			var x:Number, y:Number;
			
			while (currLen <= totalLen)
			{
				x = Ox + Math.cos(radian) * currLen;
				y = Oy +Math.sin(radian) * currLen;
				graphics.moveTo(x, y);
				
				currLen += width;
				if (currLen > totalLen) currLen = totalLen;
				
				x = Ox + Math.cos(radian) * currLen;
				y = Oy +Math.sin(radian) * currLen;
				graphics.lineTo(x, y);
				
				currLen += grap;
			}
		}
		
		/**
		 * 虚方框
		 */
		public static function virtualBox(spr:Sprite):void
		{
			spr.graphics.lineStyle(4,0xFFEC8B);
			drawDashed(spr.graphics,new Point(0,0),new Point(0,spr.height),6,8);
			drawDashed(spr.graphics,new Point(0,spr.height),new Point(spr.width,spr.height),6,8);
			drawDashed(spr.graphics,new Point(spr.width,spr.height),new Point(spr.width,0),6,8);
			drawDashed(spr.graphics,new Point(spr.width,0),new Point(0,0),6,8);
		}
		
		/**
		 * 虚圆框
		 */
		public static function virtualCircle(spr:Sprite,dot:Point = null):void
		{
			var dotClone:Point = new Point;
			if(dot == null)
			{
				dotClone = new Point(0,0);
			}else{
				dotClone = dot.clone();
			}
			
			var radius:int = spr.width>>1;
			
			var cutLen:int = 10;
			
			var circleLen:int = Math.PI*radius<<1;
			
			var cutNum:int = circleLen/cutLen;
			
			var beginPoint:Point = new Point;
			var endPoint:Point = new Point;
			
			spr.graphics.lineStyle(2,0xff0000);
			
			var i:int;
			for(i = 0; i < cutNum; i++)
			{
				var angle:Number = 360/cutNum*i;
				var radian:Number = angle*(Math.PI/180);
				var ix:int = Math.sin(radian)*radius + dotClone.x;
				var iy:int = Math.cos(radian)*radius + dotClone.y;
				
				if(i%2)
				{
					endPoint.x = ix;
					endPoint.y = iy;
					drawDashed(spr.graphics,new Point(beginPoint.x,beginPoint.y),new Point(endPoint.x,endPoint.y),2,2);
				}else{
					beginPoint.x = ix;
					beginPoint.y = iy;
				}
				
			}
		}
		
	}
}