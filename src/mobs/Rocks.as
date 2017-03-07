package mobs {
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import utils.GFX;

	import basic.BasicMob;
	import org.flixel.FlxBasic;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Rocks extends BasicMob {
		
		static private const coin:Array = [true, false];
		
		public function Rocks(X:Number = 0, Y:Number = 0) {
			super(X, Y, -1, true, 0);
			GFX.rock01(this);
			maxAngular = 300;
		}
		
		override public function draw():void {
			super.draw();
			// bounce on wall hit
			if (acceleration.x < 0 && touching & LEFT) {
				acceleration.x *= -1;
				velocity.x *= -1;
				facing = RIGHT;
				return;
			}
			else if (acceleration.x > 0 && touching & RIGHT) {
				acceleration.x *= -1;
				velocity.x *= -1;
				facing = LEFT;
				return;
			}
			if (touching & ANY) {
				kill();
			}
		}
		
		override public function overlaps(ObjectOrGroup:FlxBasic, InScreenSpace:Boolean = false, Camera:FlxCamera = null):Boolean {
			return false;
		}
		
		override public function kill():void {
			super.kill();
			exists = false;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			maxVelocity.x = 150 + FlxG.random() * 1000 % 150;
			acceleration.x = 400;
			velocity.y = -200 - FlxG.random() * 1000 % 150;
			angularAcceleration = 200 + FlxG.random() * 1000 % 100;
			if (FlxG.getRandom(coin) as Boolean) {
				acceleration.x = -400;
				angularAcceleration *= -1;
			}
		}
	}
}