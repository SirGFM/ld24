package {
	
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import states.MenuState;
	import states.PlayState;
	
	[SWF(width="500",height="500",backgroundColor="0x000000")]
	[Frame(factoryClass="Preloader")]
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Main extends FlxGame {
		
		public function Main():void {
			super(250, 250, MenuState, 2, 60, 60);
			FlxG.debug = false;
		}
	}
}
