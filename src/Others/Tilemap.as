package Others {
	
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;

	/**
	 * ...
	 * @author GFM
	 */
	public class Tilemap extends FlxTilemap {
		
		[Embed(source = "../../assets/map/tilemap.png")]
			static public var tiles:Class;
		[Embed(source = "../../assets/map/map.txt", mimeType = 'application/octet-stream')]
			static public var map:Class;
		
		public function Tilemap() {
			super();
			loadMap(new map, tiles, 16, 16, OFF, 0, 1, 4);
			
			FlxG.worldBounds.width = 3520;
			FlxG.worldBounds.height = 1440;
			FlxG.camera.setBounds(0, 0, 3520, 1440, false);
		}
	}
}
