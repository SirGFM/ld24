package mobs {

	import basic.BasicMob;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import utils.DisplayMessage;
	import utils.Enum;
	import utils.GFX;
	import utils.LivesCounter;
	import utils.Upgrade;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Player extends BasicMob {
		
		private var _attacking:Boolean;
		private var _attack_hb:FlxObject;
		private var _attack_timer:Number;
		
		private var _jump_hb:FlxObject;
		
		public var _onWater:Boolean;
		
		/**
		 * Jump stats. Each skill level is determined NL = CurStat^2/5.
		 */
		private var _st_jump:uint;
		/**
		 * Next [jump] stat on which a new level will be aquired.
		 */
		private var _st_jump_next:uint;
		/**
		 * Jump skill. Determine how high you can jump.
		 */
		private var _sk_jump:uint;
		
		/**
		 * Run stats. Each skill level is determined NL = CurStat^2/5.
		 */
		private var _st_run:uint;
		/**
		 * Next [run] stat on which a new level will be aquired.
		 */
		private var _st_run_next:uint;
		/**
		 * Run skill. Determine how fast you can jump.
		 */
		private var _sk_run:uint;
		private var _running:Boolean;
		
		public function Player(X:Number = 0, Y:Number = 0, inTiles:Boolean = true) {
			super(X, Y, -1, inTiles, 5);
			GFX.player(this);
			(FlxG.getPlugin(LivesCounter) as LivesCounter).lifePlus(health);
			
			maxVelocity.x = 125;
			drag.x = 500;
			
			_onWater = false;
			
			_st_jump = 0;
			_st_jump_next = 10;
			_sk_jump = 0;
			_st_run = 0;
			_st_run_next = 10;
			_sk_run = 0;
			_running = false;
			
			_jump_hb = new FlxObject(0, 0, 30, 4);
			
			_attacking = false;
			_attack_timer = 0;
			_attack_hb = new FlxObject(0, 0, 11, 11);
		}
		
		override public function update():void {
			super.update();
			
			// lateral movement
			if (FlxG.keys.LEFT) {
				facing = LEFT;
				if (velocity.x <= 0) 
					acceleration.x = -300;
				else 
					acceleration.x = 0;
				play("walk");
			}
			else if (FlxG.keys.RIGHT) {
				facing = RIGHT;
				if (velocity.x >= 0) 
					acceleration.x = 300;
				else 
					acceleration.x = 0;
				play("walk");
			}
			else {
				play("idle");
				acceleration.x = 0;
			}
			
			// running
			if (acceleration.x != 0) {
				maxVelocity.x = 125;
				if(FlxG.keys.C) {
					// TODO decrease stamina
					maxVelocity.x += 32.5 * _sk_run;
					_running = true;
					play("run");
				}
			}
			else {
				_running = false;
				if (velocity.x != 0)
					play("walk");
			}
			
			// jump
			if (_sk_jump > 0 && touching & FLOOR && FlxG.keys.UP) {
				// TODO fix the jump
				velocity.y = -100 - 50 * _sk_jump;
				if (_onWater) {
					velocity.y += 75;
				}
			}
			if (!(touching & FLOOR)) 
				play("jump");
			
			// tackle
			if (!_attacking && FlxG.keys.justPressed("X")) {
				if (facing == RIGHT) {
					velocity.x = 200;
					_attacking = true;
				}
				else {
					velocity.x = -200;
					_attacking = true;
				}
				_attack_timer = 0.7;
			}
			if (_attacking) {
				play("attack");
				_attack_timer -= FlxG.elapsed;
				if (_attack_timer <= 0)
					_attacking = false;
			}
			
			// on water
			if (_onWater) {
				drag.x = 300;
				acceleration.y = 200;
				maxVelocity.x = 100;
			}
			else {
				drag.x = 500;
				acceleration.y = 500;
				maxVelocity.x = 125;
			}
			if (_onWater && !isWater) {
				_onWater = false;
			}
			isWater = false;
		}
		
		override public function hurt(Damage:Number):void {
			var i:Number = health;
			super.hurt(Damage);
			(FlxG.getPlugin(LivesCounter) as LivesCounter).hurt(i - health);
		}
		
		override public function draw():void {
			super.draw();
		}
		
		public function collisionTest(mob:BasicMob):Boolean {
			// check for water
			if (mob.isWater) {
				isWater = true;
				_onWater = true;
				return false;
			}
			// jump hit-box
			if (!(touching & FLOOR)) {
				_jump_hb.x = x;
				_jump_hb.y = y + 11;
				if (mob.overlaps(_jump_hb))
					return true;
			}
			// tackle
			if (_attacking) {
				_attack_hb.x = x;
				_attack_hb.y = y + 1;
				if (facing == RIGHT) {
					_attack_hb.x += 21;
				}
				if (mob.overlaps(_attack_hb))
					return true;
			}
			if(!flickering)
				hurt(mob.damage);
			return false;
		}
		
		public function incStats(id:int):void {
			switch(id) {
				case Enum.jumper:
					jump++; break;
				case Enum.runner: 
					run++; break;
				case Enum.boss01:{
					(jump < 20)?(jump = 20):(jump += 3);
					(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue(" After absorbing this powerfull creature, you fell inside you a new power... It's as if you reached a new limit to your evolutions.\n Perhaps, it's now time to venture to unexplored lands... or even, water...", 50, 50);
				}
			}
		}
		
		public function set jump(val:uint):void {
			_st_jump = val;
			if (_sk_jump < 4) {
				if (_st_jump == _st_jump_next) {
					_st_jump_next *= _st_jump_next / 5;
					_sk_jump++;
					FlxG.flash(0xaaffffff, 0.5);
					(FlxG.getPlugin(Upgrade) as Upgrade).addToQueue("jump", _sk_jump, Enum.iconJump);
				}
			}
		}
		
		public function get jump():uint {
			return _st_jump;
		}
		
		public function set run(val:uint):void {
			_st_run = val;
			if (_sk_run < 4) {
				if (_st_run == _st_run_next) {
					_st_run_next *= _st_run_next / 5;
					_sk_run++;
					(FlxG.getPlugin(Upgrade) as Upgrade).addToQueue("run", _sk_run, Enum.iconRun);
				}
			}
		}
		
		public function get run():uint {
			return _st_run;
		}
		
		public function get n_j():uint {
			return _st_jump_next;
		}
		
		public function get n_r():uint {
			return _st_run_next;
		}
		
		public function get s_j():uint {
			return _sk_jump;
		}
		
		public function get s_r():uint {
			return _sk_run;
		}
		
		public function get attacking():Boolean {
			return _attacking;
		}
		
		public function save():Array {
			var arr:Array;
			arr = new Array();
			arr.push(x, y, _st_jump, _st_jump_next, _sk_jump, _st_run, _st_run_next, _sk_run);
			return arr;
		}
		
		public function recover(arr:Array):void {
			x = arr[0] as Number;
			y = arr[1] as Number;
			_st_jump = arr[2] as uint;
			_st_jump_next = arr[3] as uint;
			_sk_jump = arr[4] as uint;
			_st_run = arr[5] as uint;
			_st_run_next = arr[6] as uint;
			_sk_run = arr[7] as uint;
			health = 5;
			revive();
			(FlxG.getPlugin(LivesCounter) as LivesCounter).lifePlus(5);
		}
	}
}
