package mobs {

	import basic.BasicMob;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Water extends BasicMob {
		
		public function Water() {
			super(159, 34, -1, true, 1);
			// TODO GFX
			makeGraphic(848, 176, 0xaa0000aa);
			acceleration.y = 0;
			width = 848;
			height = 176;
			isWater = true;
			immovable = true;
			moves = false;
		}
		
		override public function hurt(Damage:Number):void {
			return;
		}
		
		override public function kill():void {
			return;
		}
	}
}