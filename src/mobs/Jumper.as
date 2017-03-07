package mobs {

	import basic.BasicMob;
	import org.flixel.FlxG;
	import utils.Enum;
	import utils.GFX;
	
	/**
	 * Enemy that jumps from time to time.
	 * 
	 * @author GFM
	 */
	public class Jumper extends BasicMob {
		
		/**
		 * Wait time for next jump.
		 */
		private var jumpDelay:Number;
		/**
		 * Direction to jump.
		 */
		private var dir:uint;
		/**
		 * Helps select randomly which way should jump.
		 */
		static private const selector:Array = [NONE, LEFT, RIGHT];
		
		public function Jumper(X:Number = 0, Y:Number = 0, CanRespawn:Boolean = true, inTiles:Boolean = true) {
			super(X, Y, (CanRespawn)?5: -1, inTiles, 2);
			
			GFX.jumper(this);
			
			ID = Enum.jumper;
			
			// random start
			jumpDelay = FlxG.random() * 100 % 20;
			dir = NONE;
			facing = RIGHT;
		}
		
		override public function update():void {
			super.update();
			
			jumpDelay -= FlxG.elapsed;
			
			// try to jump when timer runs out
			if (jumpDelay <= 0) {
				if (touching & FLOOR) {
					velocity.y = -250;
					
					// choose which way should jump to
					dir = FlxG.getRandom(selector) as uint;
					if(dir!=NONE){
						facing = dir;
					}
					// TODO play jump animation
				}
				// new jump time
				jumpDelay = FlxG.random() * 10 % 3 + 2;
			}
			
			// moves in the desired direction
			if (touching & FLOOR) {
				velocity.x = 0;
			}
			else if (dir == LEFT) {
				velocity.x = -50;
			}
			else if (dir == RIGHT) {
				velocity.x = 50;
			}
		}
		
		override public function kill():void {
			super.kill();
			dir = NONE;
		}
	}
}
