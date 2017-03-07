package utils {
	import org.flixel.FlxSprite;

	/**
	 * ...
	 * @author GFM
	 */
	public class GFX {
		
		[Embed(source = "../../assets/gfx/working/jumper/jumper.png")]		static private var _jumper:Class;
		[Embed(source = "../../assets/gfx/working/player/player.png")]		static private var _player:Class;
		[Embed(source = "../../assets/gfx/working/runner/runner.png")]		static private var _runner:Class;
		[Embed(source = "../../assets/gfx/working/fish/fish.png")]			static private var _fish:Class;
		[Embed(source = "../../assets/gfx/working/boss01/boss01.png")]		static private var _boss01:Class;
		[Embed(source = "../../assets/gfx/working/boss01/projectile.png")]static private var _rock01:Class;
		[Embed(source = "../../assets/gfx/working/gui/hearts.png")]			static private var _hearts:Class;
		[Embed(source = "../../assets/gfx/working/gui/jumpIcon.png")]		static private var _jumpIcon:Class;
		[Embed(source = "../../assets/gfx/working/gui/runIcon.png")]		static private var _runIcon:Class;
		[Embed(source = "../../assets/gfx/working/gui/flower.png")]			static private var _flower:Class;
		[Embed(source = "../../assets/gfx/working/gui/upgbox.png")]			static private var _upgbox:Class;
		[Embed(source = "../../assets/gfx/working/gui/box.png")]				static private var _box:Class;
		[Embed(source = "../../assets/gfx/working/gui/menuscreen.png")]	static private var _menuscreen:Class;
		
		
		static public function jumper(sprite:FlxSprite):void {
			sprite.loadGraphic(_jumper, false, true, 16, 16);
			sprite.width = 14;
			sprite.height = 14;
			sprite.centerOffsets();
		}
		
		static public function player(spr:FlxSprite):void {
			spr.loadGraphic(_player, true, true, 32, 16);
			spr.width = 30;
			spr.height = 14;
			spr.addAnimation("idle", [0], 0, false);
			spr.addAnimation("walk", [1, 0, 2, 0], 4, true);
			spr.addAnimation("run", [1, 0, 2, 0], 8, true);
			spr.addAnimation("attack", [3], 0, false);
			spr.addAnimation("jump", [4], 0, false);
			spr.centerOffsets();
		}
		
		static public function runner(spr:FlxSprite):void {
			spr.loadGraphic(_runner, false, true, 16, 16);
			spr.width = 10;
			spr.height = 12;
			spr.centerOffsets();
		}
		
		static public function fish(spr:FlxSprite):void {
			spr.loadGraphic(_fish, true, true, 16, 16);
			spr.width = 14;
			spr.height = 12;
			spr.offset.y = 3;
			spr.offset.x = 1;
			spr.addAnimation("walk", [1, 0, 2, 0], 4, true);
			// TODO animate attack
			spr.addAnimation("attack", [1, 0, 2, 0], 8, true);
		}
		
		static public function boss01(spr:FlxSprite):void {
			spr.loadGraphic(_boss01, true, true, 32, 32);
			spr.width = 18;
			spr.height = 20;
			spr.offset.x = 7;;
			spr.offset.y = 5;
			spr.addAnimation("idle", [0], 0, false);
			spr.addAnimation("walk", [1, 0, 2, 0], 8, true);
			spr.addAnimation("jump", [2], 0, false);
		}
		
		static public function rock01(spr:FlxSprite):void {
			spr.loadRotatedGraphic(_rock01, 360);
			spr.width = 9;
			spr.height = 8;
			spr.centerOffsets();
		}
		
		static public function hearts(spr:FlxSprite):void {
			spr.loadGraphic(_hearts, true, true, 8, 8);
			spr.addAnimation("alive", [0, 1], 2);
			spr.addAnimation("dead", [2, 3], 2);
			spr.play("alive");
		}
		
		static public function flower(spr:FlxSprite):void {
			spr.loadGraphic(_flower, true, false, 16, 32);
			spr.width = 10;
			spr.height = 28;
			spr.offset.x = 6;
			spr.offset.y = 3;
			spr.addAnimation("alive", [1], 0, false);
			spr.addAnimation("dead", [0], 0, false);
			spr.play("dead");
		}
		
		static public function upgBox(spr:FlxSprite):void {
			spr.loadGraphic(_upgbox, false, false, 125, 25);
		}
		
		static public function iconJump(spr:FlxSprite):void {
			spr.loadGraphic(_jumpIcon, false, false, 16, 16);
		}
		
		static public function iconRun(spr:FlxSprite):void {
			spr.loadGraphic(_runIcon, false, false, 16, 16);
		}
		
		static public function msgBox(spr:FlxSprite):void {
			spr.loadGraphic(_box);
		}
		
		static public function menuScreen(spr:FlxSprite):void {
			spr.loadGraphic(_menuscreen);
		}
	}
}
