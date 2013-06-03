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
		public static const SWINGING_LEFT_STATIONARY:String = "STATE_SWINGING_LEFT_STATIONARY";
		public static const SWINGING_LEFT_ADVANCING:String = "STATE_SWINGING_LEFT_ADVANCING";
		public static const SWINGING_RIGHT_ADVANCING:String = "STATE_SWINGING_RIGHT_ADVANCING";
		public static const SWINGING_LEFT_RECOVERY:String = "STATE_SWINGING_LEFT_RECOVERY";
		public static const SWINGING_LEFT_WAITING:String = "STATE_SWINGING_LEFT_WAITING";
		public static const SWINGING_RIGHT_RECOVERY:String = "STATE_SWINGING_RIGHT_RECOVERY";
		public static const SWINGING_RIGHT_WAITING:String = "STATE_SWINGING_RIGHT_WAITING";		
	}
}