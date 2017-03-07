package utils {
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;

	/**
	 * ...
	 * @author GFM
	 */
	public class SkillScreen extends FlxGroup {
		
		private var j_lvl:FlxText;
		private var j_exp:FlxText;
		private var j_next:FlxText;
		private var r_lvl:FlxText;
		private var r_exp:FlxText;
		private var r_next:FlxText;
		
		private var timer:Number;
		
		public function SkillScreen() {
			super();
			GFX.msgBox(add(new FlxSprite(25, 25)) as FlxSprite);
			
			add(new FlxText(120, 50, 250, "STATS"));
			
			GFX.iconJump(add(new FlxSprite(50, 75)) as FlxSprite);
			add(new FlxText(70, 75, 250, "Jump:"));
			add(new FlxText(50, 95, 250, "Level:"));
			add(new FlxText(50, 105, 250, "Cur. EXP:"));
			add(new FlxText(50, 115, 250, "Next level:"));
			j_lvl = new FlxText(85, 95, 250, "0");
			j_exp = new FlxText(98, 105, 250, "0");
			j_next = new FlxText(105, 115, 250, "0");
			
			
			GFX.iconRun(add(new FlxSprite(50, 150)) as FlxSprite);
			add(new FlxText(70, 150, 250, "Run:"));
			add(new FlxText(50, 170, 250, "Level:"));
			add(new FlxText(50, 180, 250, "Cur. EXP:"));
			add(new FlxText(50, 190, 250, "Next level:"));
			r_lvl = new FlxText(85, 170, 250, "0");
			r_exp = new FlxText(98, 180, 250, "0");
			r_next = new FlxText(105, 190, 250, "0");
			
			add(j_lvl);
			add(j_exp);
			add(j_next);
			add(r_lvl);
			add(r_exp);
			add(r_next);
			
			kill();
		}
		
		override public function update():void {
			super.update();
			timer -= FlxG.elapsed;
			if (timer > 0) {
				return;
			}
			if (FlxG.keys.any()) {
				kill();
				FlxG.paused = false;
			}
		}
		
		override public function draw():void {
			var tmp:FlxSprite;
			var i:uint = 0;
			var x:Number = FlxG.camera.scroll.x;
			var y:Number = FlxG.camera.scroll.y;
			while (i < length) {
				tmp = members[i] as FlxSprite;
				tmp.x += x;
				tmp.y += y;
				i++;
			}
			super.draw();
			i = 0
			while (i < length) {
				tmp = members[i] as FlxSprite;
				tmp.x -= x;
				tmp.y -= y;
				i++;
			}
		}
		
		public function display(a:uint,b:uint,c:uint,d:uint,e:uint,f:uint):void {
			revive();
			
			j_lvl.text = a.toString();
			j_exp.text = b.toString();
			j_next.text = c.toString();
			r_lvl.text = d.toString();
			r_exp.text = e.toString();
			r_next.text = f.toString();
			
			callAll("revive");
			FlxG.paused = true;
			timer = 0.5;
		}
	}
}
