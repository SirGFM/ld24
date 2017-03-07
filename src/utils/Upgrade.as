package utils {
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import  org.flixel.FlxSprite;
	import org.flixel.FlxText;

	/**
	 * Display which upgrade you just got.
	 * 
	 * @author GFM
	 */
	public class Upgrade extends FlxGroup{
		
		private var box:FlxSprite;
		private var text:FlxText;
		private var skillName:FlxText;
		private var icon:FlxSprite;
		
		private var fifo:Array;
		
		private var timer:Number;
		private var alpha:Number;
		
		public function Upgrade() {
			super();
			
			box = new FlxSprite();
			GFX.upgBox(box);
			icon = new FlxSprite(5, 7.5);
			text = new FlxText(20, 8, 80, "New skill:");
			skillName = new FlxText(75, 8, 100, "jump1");
			skillName.color = 0xffff3333;
			
			fifo = new Array();
			
			add(box);
			add(icon);
			add(text);
			add(skillName);
			
			kill();
		}
		
		override public function destroy():void {
			super.destroy();
			if (box) {
				box.destroy();
				box = null;
			}
			if (text) {
				text.destroy();
				text = null;
			}
			if (skillName) {
				skillName.destroy();
				skillName = null;
			}
			if (icon) {
				icon.destroy();
				icon = null;
			}
			if (fifo) {
				fifo = null;
			}
		}
		
		override public function update():void {
			super.update();
			if (timer > 0) {
				alpha += 0.025;
			}
			else {
				alpha -= 0.025;
			}
			setAll("alpha", alpha);
			timer -= FlxG.elapsed;
			if (alpha <= 0) {
				kill();
			}
		}
		
		override public function draw():void {
			setAll("x", FlxG.camera.scroll.x);
			setAll("y", FlxG.camera.scroll.y);
			icon.x += 4;
			icon.y += 4;
			text.x += 22;
			text.y += 7;
			skillName.x += 75;
			skillName.y += 7;
			super.draw();
		}
		
		override public function revive():void {
			super.revive();
			callAll("revive");
			var tmp:Array = fifo.pop();
			skillName.text = tmp[0] as String;
			switch(tmp[1] as uint) {
				case Enum.iconJump: {
					GFX.iconJump(icon);
				}break;
				case Enum.iconRun: {
					GFX.iconRun(icon);
				}break;
			}
			setAll("alpha", 0);
			alpha = 0;
			timer = 2;
		}
		
		override public function kill():void {
			super.kill();
			if (fifo.length > 0) {
				revive();
			}
		}
		
		public function addToQueue(SkillName:String, SkillLevel:uint, Icon:uint):void {
			fifo.unshift([ SkillName.concat(SkillLevel), Icon]);
			if(!alive){
				revive();
			}
		}
	}
}
