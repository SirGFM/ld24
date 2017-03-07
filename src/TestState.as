package  {

	import basic.BasicMob;
	import mobs.Jumper;
	import mobs.Player;
	import mobs.Runner;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import utils.FixedCamera;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class TestState extends FlxState {
		
		static private var switchCam:Boolean = true;
		
		public function TestState() {
			super();
		}
		
		override public function create():void {
			if (switchCam) {
				FlxG.resetCameras(new FixedCamera(0, 0, 250, 250, 2));
				switchCam = false;
			}
			add(new Player(50));
			
			/*
			add(new Jumper(200));
			add(new Jumper(232));
			add(new Jumper(124));
			add(new Jumper(156));
			*/
			add(new Runner(200));
			
			
			var tmp:FlxSprite = add(new FlxSprite(0, 200)) as FlxSprite;
			tmp.makeGraphic(250, 10);
			tmp.immovable = true;
			tmp = add(new FlxSprite(0, 0)) as FlxSprite;
			tmp.makeGraphic(10, 250);
			tmp.immovable = true;
			tmp = add(new FlxSprite(240, 0)) as FlxSprite;
			tmp.makeGraphic(10, 250);
			tmp.immovable = true;
		}
		
		override public function update():void {
			super.update();
			FlxG.collide(this, this, callback);
		}
		
		public function callback(o1:FlxObject, o2:FlxObject):void {
			if (o1 is Player && o2 is BasicMob) {
				callback2(o1 as Player, o2 as BasicMob);
			}
			else if (o1 is BasicMob && o2 is Player) {
				callback2(o2 as Player, o1 as BasicMob);
			}
		}
		
		public function callback2(pl:Player, mob:BasicMob):void {
			if (mob.alpha < 1 || mob.flickering) {
				return;
			}
			pl.incStats(mob.ID);
			mob.kill();
		}
	}
}
