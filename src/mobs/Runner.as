package mobs {
	
	import basic.BasicMob;
	import org.flixel.FlxG;
	import utils.Enum;
	import utils.GFX;

	/**
	 * Enemy that runs randomly through the map.
	 * 
	 * @author GFM
	 */
	public class Runner extends BasicMob{
		
		/**
		 * Walk left constant.
		 */
		static private const W_LEFT:uint  = 0x00001;
		/**
		 * Walk right constant.
		 */
		static private const W_RIGHT:uint = 0x00010;
		/**
		 * Run left constant.
		 */
		static private const R_LEFT:uint  = 0x00100;
		/**
		 * Run right constant.
		 */
		static private const R_RIGHT:uint = 0x01000;
		/**
		 * Stop constant.
		 */
		static private const STOP:uint	 = 0x10000;
		/**
		 * Helper for selecting action.
		 */
		static private const selector:Array = [W_LEFT, W_RIGHT, R_LEFT, R_RIGHT, R_LEFT, R_RIGHT, STOP];
		
		/**
		 * Count-down for next action.
		 */
		public var actDelay:Number;
		
		public function Runner(X:Number = 0, Y:Number = 0, CanRespawn:Boolean = true, inTiles:Boolean = true) {
			super(X, Y, (CanRespawn)?7.5: -1, inTiles);
			
			// TODO animate
			GFX.runner(this);
			
			drag.x = 300;
			facing = RIGHT;
			ID = Enum.runner;
			
			actDelay = 5 + FlxG.random() * 10 % 4;
			// TODO play idle animation
		}
		
		override public function update():void {
			super.update();
			actDelay -= FlxG.elapsed;
			if (actDelay <= 0) {
				var t:uint = FlxG.getRandom(selector) as uint;
				switch(t) {
					case W_LEFT:
					case W_RIGHT: {
						maxVelocity.x = 75;
						acceleration.x = 300;
						facing = RIGHT;
						actDelay = 2 + FlxG.random() * 10 % 4;
						// TODO play walk animation
					}break;
					case W_LEFT:
					case W_RIGHT: {
						maxVelocity.x = 200;
						acceleration.x = 300;
						facing = RIGHT;
						actDelay = 4 + FlxG.random() * 10 % 4;
						// TODO play run animation
					}break;
					case STOP: {
						acceleration.x = 0;
						actDelay = 3 + FlxG.random() * 10 % 7;
						// TODO play idle animation
					}break;
				}
				if (t & (W_LEFT | R_LEFT)) {
					acceleration.x *= -1;
					facing = LEFT;
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
		}
	}
}
