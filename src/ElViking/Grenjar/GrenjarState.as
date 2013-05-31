package ElViking.Grenjar
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	import org.flixel.FlxG;
	
	/**
	 * Enumerates all of the Grenjar's states!
	 * 
	 * @author Philjo
	 */
	internal class GrenjarState
	{
		public static const STANDING:String = "STATE_STANDING";
		public static const WALKING:String  = "STATE_WALKING";
		public static const BLOCKING:String = "STATE_BLOCKING";
		public static const SWINGING:String = "STATE_SWINGING";
	}
}