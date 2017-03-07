package mobs {

	import basic.BasicMob;
	import org.flixel.FlxG;
	import states.PlayState;
	import utils.Enum;
	import utils.GFX;
	import utils.SFX;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss01 extends BasicMob {
		
		static private const STOP:uint   = 0x0001;
		static private const WALK_L:uint = 0x0010;
		static private const WALK_R:uint = 0x0100;
		static private const JUMP:uint   = 0x1000;
		static private const selector:Array = [STOP, WALK_L, WALK_R, JUMP, JUMP, JUMP];
		
		private var startup:Boolean;
		private var actionTimer:Number;
		
		public function Boss01(X:Number=0, Y:Number=0) {
			super(X, Y, -1, true, 20);
			GFX.boss01(this);
			
			damage = 1.5;
			ID = Enum.boss01;;
			
			startup = false;
			actionTimer = 1.5;
			maxVelocity.x = 225;
			drag.x = 300;
		}
		
		override public function update():void {
			if (!startup) {
				if (onScreen()) {
					SFX.bossSong();
					startup = true;
				}
				else {
					return;
				}
			}
			super.update();
			actionTimer -= FlxG.elapsed;
			if (actionTimer <= 0) {
				switch(FlxG.getRandom(selector) as uint) {
					case STOP: {
						play("idle");
						acceleration.x = 0;
						actionTimer += FlxG.random() * 10 % 2;
					}break;
					case WALK_L: {
						facing = LEFT;
						acceleration.x = -300;
						play("walk");
						actionTimer += 1 + FlxG.random() * 10 % 2;
					}break;
					case WALK_R: {
						facing = RIGHT;
						acceleration.x = 300;
						play("walk");
						actionTimer += 1 + FlxG.random() * 10 % 2;
					}break;
					case JUMP: {
						velocity.y = -200;
						play("jump");
						actionTimer += 2;
					}break;
				}
			}
			
			
			// bounce on wall hit
			if (acceleration.x < 0 && touching & LEFT) {
				acceleration.x *= -1;
				facing = RIGHT;
			}
			else if (acceleration.x > 0 && touching & RIGHT) {
				acceleration.x *= -1;
				facing = LEFT;
			}
			
			if (justTouched(FLOOR)) {
				// spawn rocks
				var n:uint = FlxG.random() * 10 % 6 + 1;
				while (n > 0) {
					(PlayState.self.projectiles.recycle(Rocks) as Rocks).reset(x + 15, y + 25);
					n--;
				}
				play("idle");
			}
		}
		
		override public function kill():void {
			super.kill();
			SFX.stageSong();
		}
	}
}
