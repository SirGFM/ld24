package utils {

	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class LivesCounter extends FlxGroup {
		
		public function LivesCounter() {
			super();
		}
		
		override public function draw():void {
			var tmp:FlxSprite;
			var i:uint = 0;
			var x:Number = FlxG.camera.scroll.x;
			var y:Number = FlxG.camera.scroll.y;
			while (i < length) {
				tmp = members[i] as FlxSprite;
				tmp.x += x;
				tmp.y += y;
				i++;
			}
			super.draw();
			i = 0
			while (i < length) {
				tmp = members[i] as FlxSprite;
				tmp.x -= x;
				tmp.y -= y;
				i++;
			}
		}
		
		public function lifePlus(n:uint):void {
			var tmp:FlxSprite = getLastDead() as FlxSprite;
			while ((tmp != null) && (n > 0)) {
				tmp.alive = true;
				tmp.play("alive");
				tmp = getLastDead() as FlxSprite;
				n--;
			}
			while (n > 0) {
				tmp = (length > 0)?(members[length - 1] as FlxSprite):null;
				if (tmp == null) {
					tmp = new FlxSprite(237, 5);
				}
				else {
					if(tmp.x >= 185){
						tmp = new FlxSprite(tmp.x - 5 - 8, tmp.y);
					}
					else {
						tmp = new FlxSprite(237, tmp.y - 8 - 5);
					}
				}
				GFX.hearts(tmp);
				add(tmp);
				n--;
			}
		}
		
		public function hurt(n:uint):void {
			var tmp:FlxSprite;
			while (n > 0) {
				tmp = getFirstAlive() as FlxSprite;
				tmp.alive = false;
				tmp.play("dead");
				n--;
			}
		}
		
		public function getLastDead():FlxBasic
		{
			var basic:FlxBasic;
			var i:int = length;
			if (i == 0)
				return null;
			i--;
			while(i >= 0)
			{
				basic = members[i--] as FlxBasic;
				if((basic != null) && basic.exists && !basic.alive)
					return basic;
			}
			return null;
		}
	}
}
