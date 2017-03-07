package utils {
	import org.flixel.FlxG;

	/**
	 * ...
	 * @author GFM
	 */
	public class SFX {
		
		[Embed(source = "../../assets/sfx/ld24_song1.mp3")]	static private var _menuSong:Class;
		[Embed(source = "../../assets/sfx/ld24_song2.mp3")]	static private var _stageSong:Class;
		[Embed(source = "../../assets/sfx/ld24_song3.mp3")]	static private var _bossSong:Class;
		
		static public function menuSong():void {
			FlxG.playMusic(_menuSong);
		}
		
		static public function stageSong():void {
			FlxG.playMusic(_stageSong);
		}
		
		static public function bossSong():void {
			FlxG.playMusic(_bossSong);
		}
	}
}
