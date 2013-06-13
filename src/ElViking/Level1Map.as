package ElViking 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	/**
	 * ...
	 * @author ...
	 */
	public class Level1Map extends FlxTilemap
	{			
		[Embed(source = "../../data/level1/map.txt", mimeType = "application/octet-stream")] 
		private static var LevelOneMap:Class;
		[Embed(source = "../../data/level1/maptiles.png")] 
		private static var LevelOneMapTiles:Class;
		
		public function Level1Map()
		{
			super();
		}
		
		public function loadMapOne():void
		{
			super.loadMap(new LevelOneMap, LevelOneMapTiles, 20, 20);
			
			update();
		}
		
		override public function update():void
		{
			var tile:FlxTile = _tileObjects[1] as FlxTile;
			tile.solid = false;
			tile.allowCollisions = NONE;
			
			tile = _tileObjects[0] as FlxTile;
			tile.solid = true;
			tile.allowCollisions = ANY;
		}
	}
}