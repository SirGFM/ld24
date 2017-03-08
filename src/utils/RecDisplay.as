package utils {
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	/**
	 * ...
	 * @author GFM
	 */
	public class RecDisplay extends FlxGroup {
		
		[Embed(source = "../../assets/save/keys.png")] private var gfx:Class;
		
		private var left:FlxSprite;
		private var right:FlxSprite;
		private var up:FlxSprite;
		private var down:FlxSprite;
		private var x:FlxSprite;
		private var c:FlxSprite;
		private var k:FlxSprite;
		
		public function RecDisplay() {
			x = new FlxSprite(5, 14);
			x.loadGraphic(gfx, true, false, 8, 8);
			x.frame = 2;
			c = new FlxSprite(14, 14);
			c.loadGraphic(gfx, true, false, 8, 8);
			c.frame = 3;
			k = new FlxSprite(23, 14);
			k.loadGraphic(gfx, true, false, 8, 8);
			k.frame = 7;
			left = new FlxSprite(37, 14);
			left.loadGraphic(gfx, true, false, 8, 8);
			left.frame = 4;
			down = new FlxSprite(46, 14);
			down.loadGraphic(gfx, true, false, 8, 8);
			down.frame = 5;
			right = new FlxSprite(55, 14);
			right.loadGraphic(gfx, true, false, 8, 8);
			right.frame = 6;
			up = new FlxSprite(46, 5);
			up.loadGraphic(gfx, true, false, 8, 8);
			up.frame = 1;
			
			add(x);
			add(c);
			add(k);
			add(left);
			add(down);
			add(right);
			add(up);
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.LEFT) {
				left.alpha = 1;
			}
			else {
				left.alpha = 0.33;
			}
			if (FlxG.keys.RIGHT) {
				right.alpha = 1;
			}
			else {
				right.alpha = 0.33;
			}
			if (FlxG.keys.UP) {
				up.alpha = 1;
			}
			else {
				up.alpha = 0.33;
			}
			if (FlxG.keys.DOWN) {
				down.alpha = 1;
			}
			else {
				down.alpha = 0.33;
			}
			if (FlxG.keys.X) {
				x.alpha = 1;
			}
			else {
				x.alpha = 0.33;
			}
			if (FlxG.keys.C) {
				c.alpha = 1;
			}
			else {
				c.alpha = 0.33;
			}
			if (FlxG.keys.K) {
				k.alpha = 1;
			}
			else {
				k.alpha = 0.33;
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
	}
}
