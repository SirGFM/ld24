package Others {

	import basic.BasicMob;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class WinCondition extends BasicMob {
		
		public function WinCondition() {
			super(196,36, -1, true, 1);
			makeGraphic(240, 128, 0x00000000);
		}
		
		override public function hurt(Damage:Number):void { return; }
		override public function kill():void { return; }
	}
}