package mobs {

	import basic.BasicMob;
	import org.flixel.FlxG;
	import utils.GFX;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Fish extends BasicMob {
		
		
		static private const WALK_L:uint = 0x0001;
		static private const WALK_R:uint = 0x0010;
		static private const WALK_U:uint = 0x0100;
		static private const WALK_D:uint = 0x1000;
		static private const ATK_L:uint =  0x00010000;
		static private const ATK_R:uint =  0x00100000;
		static private const ATK_U:uint =  0x01000000;
		static private const ATK_D:uint =  0x10000000;
		
		static private const selector:Array = [WALK_L, WALK_R, WALK_U, WALK_D, ATK_L, ATK_R, ATK_U, ATK_D];
		private var delay:Number;
		
		public function Fish(X:Number = 0, Y:Number = 0, CanRespawn:Boolean = true) {
			super(X, Y, (CanRespawn)?5: -1, true, 7);
			GFX.fish(this);
			acceleration.y = 0;
			drag.x = 100;
			drag.y = 100;
			maxVelocity.x = 150;
			maxVelocity.y = 150;
			delay = 0;
		}
		
		override public function update():void {
			super.update();
			delay -= FlxG.elapsed;
			if (delay <= 0) {
				switch(FlxG.getRandom(selector) as uint) {
					case WALK_L: {
						acceleration.x = -200;
						acceleration.y = 0;
						play("walk");
						delay += 0.5 + FlxG.random() * 10 % 3;
					}break;
					case WALK_R: {
						acceleration.x = 200;
						acceleration.y = 0;
						play("walk");
						delay += 0.5 + FlxG.random() * 10 % 3;
					}break;
					case WALK_U: {
						acceleration.x = 0;
						acceleration.y = -200;
						play("walk");
						delay += 0.5 + FlxG.random() * 10 % 3;
					}break;
					case WALK_D: {
						acceleration.x = 0;
						acceleration.y = 200;
						play("walk");
						delay += 0.5 + FlxG.random() * 10 % 3;
					}break;
					case ATK_L: {
						acceleration.x = 200;
						velocity.x = 300;
						acceleration.y = 0;
						play("attack");
						delay += 1.5 + FlxG.random() * 10 % 3;
					}break;
					case ATK_R: {
						acceleration.x = -200;
						velocity.x = -300;
						acceleration.y = 0;
						play("attack");
						delay += 1.5 + FlxG.random() * 10 % 3;
					}break;
					case ATK_U: {
						acceleration.x = 0;
						acceleration.y = -200;
						velocity.y = -300;
						play("attack");
						delay += 1.5 + FlxG.random() * 10 % 3;
					}break;
					case ATK_D: {
						acceleration.x = 0;
						acceleration.y = 200;
						velocity.y = 300;
						play("attack");
						delay += 1.5 + FlxG.random() * 10 % 3;
					}break;
				}
			}
			
			// bounce on wall hit
			if (acceleration.x < 0 && touching & LEFT) {
				acceleration.x *= -1;
				velocity.x *= -1;
				facing = RIGHT;
			}
			else if (acceleration.x > 0 && touching & RIGHT) {
				acceleration.x *= -1;
				velocity.x *= -1;
				facing = LEFT;
			}
			else if (acceleration.y < 0 && touching & UP) {
				acceleration.y *= -1;
				velocity.y *= -1;
			}
			else if (acceleration.y > 0 && touching & DOWN) {
				acceleration.y *= -1;
				velocity.y *= -1;
			}
		}
	}
}
