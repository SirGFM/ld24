package states {
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import utils.DisplayMessage;
	import utils.GFX;
	import utils.LivesCounter;
	import utils.SFX;
	import utils.Upgrade;

	/**
	 * ...
	 * @author GFM
	 */
	public class MenuState extends FlxState {
		
		[Embed(source = "../../assets/gfx/working/gui/help.txt", mimeType = 'application/octet-stream')]	static private var text:Class;
		[Embed(source = "../../assets/gfx/working/gui/help2.txt", mimeType = 'application/octet-stream')]	static private var text2:Class;
		[Embed(source = "../../assets/gfx/working/gui/help3.txt", mimeType = 'application/octet-stream')]	static private var text3:Class;
		[Embed(source = "../../assets/gfx/working/gui/help4.txt", mimeType = 'application/octet-stream')]	static private var text4:Class;
		
		public function MenuState() {
			
		}
		
		override public function create():void {
			super.create();
			
			FlxG.mouse.show();
			
			// plugin that displays upgrades (when you get'em)
			if(FlxG.getPlugin(Upgrade) == null){
				FlxG.addPlugin(new Upgrade());
			}
			// for showing messages (also, pausing)
			if(FlxG.getPlugin(DisplayMessage) == null){
				FlxG.addPlugin(new DisplayMessage());
			}
			
			GFX.menuScreen(add(new FlxSprite(0, 0)) as FlxSprite);
			
			add(new FlxButton(130, 75, "PLAY",
					function():void {
						FlxG.fade
						(0xff000000, 1,
								function():void { 
									FlxG.mouse.hide();
									FlxG.switchState(new PlayState(false, false, true));
								} 
						); 
						FlxG.music.fadeOut(0.8);
					} 
				));
			add(new FlxButton(145, 100, "HELP",
					function():void {
						(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue(new text, 50, 50);
						(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue(new text2, 50, 50);
						(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue(new text3, 50, 50);
						(FlxG.getPlugin(DisplayMessage) as DisplayMessage).addToQueue(new text4, 50, 30);
					}
				));
			add(new FlxButton(160, 125, "DEMO",
					function():void {
						FlxG.fade
						(0xff000000, 1,
								function():void { 
									FlxG.mouse.hide();
									FlxG.switchState(new PlayState(false, true, true));
								} 
						); 
						FlxG.music.fadeOut(0.8);
					} 
				));
			/*
			add(new FlxButton(220, 210, "REC",
					function():void {
						FlxG.fade
						(0xff000000, 1,
								function():void { 
									FlxG.mouse.hide();
									FlxG.switchState(new PlayState(true, false, true));
								} 
						); 
						FlxG.music.fadeOut(0.8);
					} 
				));
			*/
			(add(new FlxText(100, 30, 200, "EVO - X")) as FlxText).size = 16;
			add(new FlxText(15, 235, 250, "A game by GFM - Made in 48h for LudumDare"));
			
			SFX.menuSong();
		}
	}
}	