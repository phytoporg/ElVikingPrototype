package ElViking
{
	import org.flixel.*;
	import ElViking.Grenjar.GrenjarGroup;
	import org.flixel.system.FlxTile;
	
	/**
	 * Initializes and contains all El Viking prototype objects!
	 * 
	 * @author Philjo
	 */
	
	public class GameState extends FlxState
	{
		//
		// Level 1 resources
		//
		
		[Embed(source = "../../data/level1/map.txt", mimeType = "application/octet-stream")] 
		private static var LevelOneMap:Class;
		[Embed(source = "../../data/level1/maptiles.png")] 
		private static var LevelOneMapTiles:Class;
		
		public var grenjar:GrenjarGroup;
		override public function create():void
		{
			grenjar = new GrenjarGroup();
			add(grenjar);
			
			var tileMap:FlxTilemap = loadMap(0);
			add(tileMap);
		}
		
		private static const NUM_LEVELS:uint = 1;
		private function loadMap(index:uint):FlxTilemap
		{
			var tileMap:FlxTilemap = new FlxTilemap();
			tileMap.loadMap(new LevelOneMap, LevelOneMapTiles, 20, 20);
			tileMap.revive();
			tileMap.visible = true;
			return tileMap;
		}
	}

}