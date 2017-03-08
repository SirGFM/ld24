package Others {

	import basic.BasicMob;
	import mobs.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import utils.GFX;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Checkpoint extends BasicMob {
		
		static public var last:Checkpoint = null;
		private var memory:Array;
		
		public function Checkpoint(X:Number = 0, Y:Number = 0) {
			super(X, Y);
			GFX.flower(this);
		}
		
		public function recover(pl:Player):void {
			pl.recover(memory);
		}
		
		public function save(pl:Player):void {
			
			// nothing makes sense anymore >_<
			
			//FlxG.log(last is FlxPoint);
			//FlxG.log(last==null);
			if (!(last is FlxPoint)) {
				// FUCK YOU SHITTY COMPILER!
				(last as BasicMob).play("dead");
			}
			memory = pl.save();
			// AAAAAARRRRRRG WHY DO i CODE USING THIS??? >_<
			Checkpoint.last = this;
			play("alive");
		}
		
		override public function hurt(Damage:Number):void { return; }
		override public function kill():void { return; }
	}
}