package states {

	import basic.BasicMob;
	import mobs.Jumper;
	import mobs.Runner;
	import mobs.Player;
	import mobs.Water;
	import mobs.Boss01;
	import mobs.Fish;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import Others.Checkpoint;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import Others.Checkpoint;
	import Others.Tilemap;
	import Others.WinCondition;
	import utils.DisplayMessage;
	import utils.FixedCamera;
	import utils.LivesCounter;
	import utils.SFX;
	import utils.SkillScreen;
	import utils.Upgrade;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlayState extends FlxState {
		
		static private var switchCam:Boolean = true;
		
		static public var self:PlayState;
		
		private var tilemap:FlxTilemap;
		private var player:Player;
		private var baddies:FlxGroup;
		public var projectiles:FlxGroup;
		private var mobs:FlxGroup;
		private var endgame:Boolean;
		private var gamewon:Boolean;
		private var pauseSpr:FlxSprite;
		private var wincondition:WinCondition;
		
		public function PlayState() {
			super();
		}
		
		override public function create():void {
			super.create();
			
			self = this;
			
			FlxG.bgColor = 0xff8c491a;
			
			// life counter
			FlxG.addPlugin(new LivesCounter());
			FlxG.addPlugin(new SkillScreen());
			
			// change the camera
			if (switchCam) {
				FlxG.resetCameras(new FixedCamera(0, 0, 250, 250, 2));
				switchCam = false;
			}
			
			// create everything
			mobs = new FlxGroup();
			tilemap = new Tilemap();
			
			baddies = new FlxGroup();
			projectiles = new FlxGroup();
			
			
			baddies.add(new Jumper(87, 6, false));
			baddies.add(new Jumper(55, 9, false));
			baddies.add(new Jumper(13, 10, false));
			baddies.add(new Runner(45, 11, true));
			baddies.add(new Jumper(47, 11, false));
			baddies.add(new Runner(50, 11, true));
			baddies.add(new Runner(63, 11, true));
			baddies.add(new Jumper(67, 11, false));
			baddies.add(new Runner(70, 11, true));
			baddies.add(new Runner(93, 11, true));
			baddies.add(new Jumper(28, 14, false));
			baddies.add(new Jumper(48, 19, false));
			baddies.add(new Jumper(38, 21, false));
			baddies.add(new Jumper(30, 22, false));
			baddies.add(new Jumper(18, 25, false));
			baddies.add(new Jumper(20, 25, false));
			baddies.add(new Jumper(22, 25, false));
			baddies.add(new Jumper(43, 25, false));
			baddies.add(new Jumper(129, 25, false));
			baddies.add(new Jumper(122, 27, false));
			baddies.add(new Jumper(115, 30, false));
			baddies.add(new Jumper(31, 32, false));
			baddies.add(new Jumper(28, 33, false));
			baddies.add(new Jumper(23, 34, false));
			baddies.add(new Jumper(89, 34, false));
			baddies.add(new Jumper(105, 34, false));
			baddies.add(new Jumper(16, 35, true));
			baddies.add(new Jumper(19, 35, false));
			baddies.add(new Runner(84, 35, true));
			baddies.add(new Jumper(5, 36, true));
			baddies.add(new Jumper(8, 36, true));
			baddies.add(new Jumper(12, 36, true));
			baddies.add(new Boss01(145, 36));
			baddies.add(new Fish(178, 36, true));
			baddies.add(new Fish(186, 36, true));
			baddies.add(new Runner(52, 37, true));
			baddies.add(new Runner(73, 37, true));
			baddies.add(new Fish(169, 37, true));
			baddies.add(new Runner(59, 38, true));
			baddies.add(new Jumper(63, 38, false));
			baddies.add(new Fish(173, 39, true));
			baddies.add(new Fish(167, 40, true));
			baddies.add(new Fish(197, 40, true));
			/*
			baddies.add(new Checkpoint(14, 9));
			baddies.add(new Checkpoint(128, 24));
			baddies.add(new Checkpoint(48, 25));
			baddies.add(new Checkpoint(28, 27));
			baddies.add(new Checkpoint(156, 30));
			baddies.add(new Checkpoint(50, 35));
			*/
			
			baddies.add(projectiles);
			
			// add water overlap
			baddies.add(new Water());
			// add cheap win condition
			wincondition = new WinCondition();
			baddies.add(wincondition);
			
			player = add(new Player(3, 17)) as mobs.Player;
			FlxG.camera.follow(player);
			
			// fucking shitty compiler!
			(mobs as FlxGroup).add(baddies);
			(mobs as FlxGroup).add(player);
			
			// add everything
			add(tilemap);
			add(baddies);
			add(player);
			SFX.stageSong();
			Checkpoint.last = null;
			endgame = false;
			gamewon = false;
			pauseSpr = new FlxSprite();
			pauseSpr.makeGraphic(250, 250, 0x77222222);
		}
		
		override public function destroy():void {
			FlxG.camera.follow(null);
			FlxG.removePluginType(LivesCounter);
			FlxG.removePluginType(SkillScreen);
			super.destroy();
		}
		
		override public function update():void {
			if (FlxG.paused){
				return;
			}
			if (gamewon && !((FlxG.getPlugin(DisplayMessage)).alive)) {
				FlxG.fade(0xff000000, 1, function():void { FlxG.switchState(new MenuState()); } );
				FlxG.music.fadeOut(0.8);
			}
			if (!player.alive) {
				if (endgame && !((FlxG.getPlugin(DisplayMessage)).alive)) {
					FlxG.fade(0xff000000, 1, function():void { FlxG.switchState(new MenuState()); } );
					FlxG.music.fadeOut(0.8);
				}/**/
				else {
					(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue("\n\n\t\t\tYou died.\n\n\n\tPress any key to go back to the menu.", 50, 50);
					endgame = true;
				}
				/*
				if((Checkpoint.last != null) && !(Checkpoint.last is FlxPoint)){
					FlxG.flash(0xffffffff, 0.5, function():void{Checkpoint.last.recover(player)});
				}
				else {
					(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue("\n\n\t\t\tYou died.\n\n\n\tPress any key to go back to the menu.", 50, 50);
					endgame = true;
				}
				/**/
			}
			super.update();
			
			FlxG.collide(mobs, tilemap);
			FlxG.overlap(player, baddies, onOverlap, checkCollision);
			
			if (FlxG.keys.P){
				(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue("\t\t\tPAUSED", 50, 110);
			}
			if (FlxG.keys.K) {
				(FlxG.getPlugin(SkillScreen) as SkillScreen).display(player.s_j, player.jump, player.n_j, player.s_r, player.run, player.n_r);
			}
		}
		
		override public function draw():void {
			super.draw();
			if (FlxG.paused) {
				pauseSpr.x = FlxG.camera.scroll.x;
				pauseSpr.y = FlxG.camera.scroll.y;
				pauseSpr.draw();
			}
		}
		
		public function checkCollision(pl:Player, mob:BasicMob):Boolean {
			if (mob is Checkpoint) {
				if(Checkpoint.last != mob)
					(mob as Checkpoint).save(player);
				return false;
			}
			else if (mob is WinCondition) {
				if(!gamewon)
					(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue("Even though your adventure is at it's start...\n\nI'm afraid there's nothing else here...\n\nPerhaps, someday you will be able to conclude this journey...\n\n\n\t\t\t~FIN~\n\n(Press any key to go back)", 50, 50);
				gamewon = true;
				return false;
			}
			return mob.alpha == 1 && !mob.flickering && pl.collisionTest(mob);
		}
		
		public function onOverlap(pl:Player, mob:BasicMob):void {
			mob.hurt(pl.damage);
			if (!mob.alive) {
				pl.incStats(mob.ID);
				mob.kill();
			}
		}
	}
}
