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
		private var _grenjar:GrenjarGroup;
		public function get grenjar():GrenjarGroup
		{
			return _grenjar;
		}
		
		private var _tileMap:FlxTilemap;
		public function tileMap():FlxTilemap
		{
			return _tileMap;
		}
		
		private var _collisionTiles:FlxGroup;
		public function get collisionTiles():FlxGroup
		{
			return _collisionTiles;
		}
		
		override public function create():void
		{			
			_tileMap = loadMap(0);
			add(_tileMap);
			
			_grenjar = new GrenjarGroup();
			add(_grenjar);
			
			FlxG.camera.follow(_grenjar.body, 3.5);
		}
		
		private static const NUM_LEVELS:uint = 1;
		private function loadMap(index:uint):FlxTilemap
		{
			var tileMap:Level1Map = new Level1Map();
			tileMap.loadMapOne();
			tileMap.revive();
			tileMap.visible = true;
			return tileMap;
		}
		
		private function myCollisionFunction(obj1:FlxObject, obj2:FlxObject):void
		{
			// do nothing I guess
		}
		
		override public function update():void
		{
			super.update();
		
			FlxG.worldBounds.x = FlxG.camera.scroll.x as uint;
			FlxG.worldBounds.y = FlxG.camera.scroll.y as uint;
			FlxG.worldBounds.width = 10000; // TODO: Define this for real somewhere!
			FlxG.worldBounds.height = 10000;
			
			var tileMap:Level1Map = _tileMap as Level1Map;
			FlxG.collide(_grenjar.body, tileMap, myCollisionFunction);
		}
	}
}