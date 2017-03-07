package utils {

	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class DisplayMessage extends FlxGroup {
		
		private var box:FlxSprite;
		private var text:FlxText;
		private var x:Number;
		private var y:Number;
		
		private var fifo:Array;
		
		private var timer:Number;
		private var alpha:Number;
		
		public function DisplayMessage() {
			super();
			
			box = new FlxSprite();
			GFX.msgBox(box);
			text = new FlxText(20, 8, 150, "");
			
			fifo = new Array();
			
			add(box);
			add(text);
			
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
			if (fifo) {
				fifo = null;
			}
		}
		
		override public function update():void {
			super.update();
			if (alpha < 1) {
				alpha += 0.025;
				setAll("alpha", alpha);
			}
			else if (FlxG.keys.any()) {
				kill();
				FlxG.paused = false;
			}
		}
		
		override public function draw():void {
			setAll("x", FlxG.camera.scroll.x);
			setAll("y", FlxG.camera.scroll.y);
			box.x += 25;
			box.y += 25;
			text.x += x;
			text.y += y;
			super.draw();
		}
		
		override public function revive():void {
			super.revive();
			callAll("revive");
			
			var tmp:Array = fifo.pop();
			text.text = tmp[0] as String;
			text.color = tmp[1] as uint;
			x = tmp[2] as Number;
			y = tmp[3] as Number;
			text.width = 250 - x;
			setAll("alpha", 0);
			alpha = 0;
			FlxG.paused = true;
		}
		
		override public function kill():void {
			super.kill();
			if (fifo.length > 0) {
				revive();
			}
		}
		
		public function addToQueue(text:String, x:Number, y:Number, color:uint = 0xffffffff):void {
			fifo.unshift([text, color, x, y]);
			if(!alive){
				revive();
			}
		}
	}
}