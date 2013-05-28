package ElViking
{
	import org.flixel.*;
	import ElViking.Grenjar.GrenjarGroup;
	
	/**
	 * Initializes and contains all El Viking prototype objects!
	 * 
	 * @author Philjo
	 */
	public class GameState extends FlxState
	{
		public var grenjar:GrenjarGroup;
		
		override public function create():void
		{
			grenjar = new GrenjarGroup();
			add(grenjar);
		}
	}

}