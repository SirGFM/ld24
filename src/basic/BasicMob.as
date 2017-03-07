package basic {

	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * Basic mob class. It allows 
	 * 
	 * @author GFM
	 */
	public class BasicMob extends FlxSprite {
		
		/**
		 * Cheap... for overlaping with water 
		 */
		public var isWater:Boolean;
		/**
		 * Original X position.
		 */
		private var oX:Number;
		/**
		 * Original Y position.
		 */
		private var oY:Number;
		/**
		 * Original health.
		 */
		private var oHealth:Number;
		/**
		 * When should the mob respawn after dying.
		 */
		private var respawnTime:Number;
		/**
		 * Counter used to respawn the mob.
		 */
		public var __timer:Number;
		/**
		 * Whether the mob can respawn.
		 */
		private var canRespawn:Boolean;
		/**
		 * How much damage this mob cause.
		 */
		public var damage:Number;
		
		/**
		 * Constructor.
		 * 
		 * @param	X				Initial X position.
		 * @param	Y				Initial Y position.
		 * @param	RespawnTime	When should the mob respawn after dying. (-1 for never)
		 */
		public function BasicMob(X:Number = 0, Y:Number = 0, RespawnTime:Number = -1, inTiles:Boolean = true, Health:Number = 3) {
			super(X, Y);
			acceleration.y = 500;
			maxVelocity.y = 300;
			respawnTime = RespawnTime;
			canRespawn = respawnTime >= 0;
			oX = X;
			oY = Y;
			damage = 1;
			health = Health;
			oHealth = Health;
			isWater = false;
			if (inTiles) {
				x *= 16;
				y *= 16;
				oX *= 16;
				oY *= 16;
			}
			
		}
		
		override public function update():void {
			super.update();
			// counter to revive the mob
			if (!alive && canRespawn) {
				__timer -= FlxG.elapsed;
				if (__timer <= 0) {
					reset(oX, oY);
					alpha = 0.01;
				}
			}
			// fade in
			if (alpha < 1) {
				alpha += 0.02;
			}
		}
		
		override public function postUpdate():void {
			if (!onScreen() && alive) {
				return;
			}
			super.postUpdate();
		}
		
		override public function hurt(Damage:Number):void {
			super.hurt(Damage);
			flicker(3);
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			health = oHealth;
			visible = true;
			solid = true;
		}
		
		override public function kill():void {
			super.kill();
			if(canRespawn){
				exists = true;
				visible = false;
				solid = false;
				__timer = respawnTime;
			}
		}
	}
}
