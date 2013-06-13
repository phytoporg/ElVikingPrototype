package ElViking.Grenjar
{
	import EntityLib.StateMachine;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.flixel.*;
	
	/**
	 * Grenjar sprite class!
	 * 
	 * @author Philjo
	 */
	internal class Grenjar extends FlxSprite
	{	
		//
		// Constants 
		//
		
		public static const WALK_SPEED:int    = 150;
		public static const LUNGE_SPEED:int   = 300;
		public static const SPRITE_HEIGHT:int = 25;
		public static const SPRITE_WIDTH:int  = 25;
		
		public static const SWING_BEGIN_ANGLE:Number       = 30;
		public static const SWING_END_ANGLE:Number         = 100;
		public static const SWING_RECOVERY_DURATION_MS:int = 10;
		public static const SWING_WAIT_DURATION_MS:int     = 150;
		public static const SWING_DURATION_MS:int          = 150;
		
		public static const LEAP_START_DURATION_MS:int     = 20;
		public static const LEAP_DURATION_MS:int           = 120;
		public static const LEAP_SCALE_MAX:Number          = 1.5;
		public static const LEAP_SPEED:Number              = 900;
		public static const LEAP_RECOVERY_MS:int           = 50;
		
		//
		// Tracks the direction Grenjar is currently facing
		//
		
		private var _direction:Point;
		public function get direction():Point
		{
			return _direction;
		}
		
		//
		// The internal state machine! 
		//
		
		private var _stateMachine:StateMachine;
		public function get stateMachine():StateMachine
		{
			return _stateMachine;
		}
		
		public function Grenjar() 
		{
			super(-100, -100);
			makeGraphic(SPRITE_HEIGHT, SPRITE_WIDTH);
			color = FlxU.makeColor(128, 0, 0, 1.0);
			kill();
			
			//
			// Face up by default
			//
			
			_direction = new Point(0, 1);
			
			//
			// Initialize the state machine.
			//
			
			var stateDictionary:Dictionary = new Dictionary();
			stateDictionary[GrenjarState.WALKING]  = new GrenjarStateWalking();
			stateDictionary[GrenjarState.STANDING] = new GrenjarStateStanding();
			stateDictionary[GrenjarState.BLOCKING] = new GrenjarStateBlocking();
			stateDictionary[GrenjarState.SWINGING_LEFT_STATIONARY] = new GrenjarStateSwingingLeftStationary();
			stateDictionary[GrenjarState.SWINGING_LEFT_ADVANCING]  = new GrenjarStateSwingingLeftAdvancing();			
			stateDictionary[GrenjarState.SWINGING_RIGHT_ADVANCING] = new GrenjarStateSwingingRightAdvancing();
			stateDictionary[GrenjarState.SWINGING_LEFT_RECOVERY]   = new GrenjarStateSwingLeftRecovery();
			stateDictionary[GrenjarState.SWINGING_LEFT_WAITING]    = new GrenjarStateSwingLeftWait();	
			stateDictionary[GrenjarState.SWINGING_RIGHT_RECOVERY]  = new GrenjarStateSwingRightRecovery();
			stateDictionary[GrenjarState.SWINGING_RIGHT_WAITING]   = new GrenjarStateSwingRightWait();
			stateDictionary[GrenjarState.STARTING_LEAP]            = new GrenjarStateStartingLeap();
			stateDictionary[GrenjarState.LEAPING]                  = new GrenjarStateLeaping();
			stateDictionary[GrenjarState.LEAP_RECOVERY]            = new GrenjarStateLeapRecovery();
			
			_stateMachine = 
				new StateMachine(
					GrenjarState.STANDING, 
					stateDictionary
					);
		}
		
		private function updateState():void
		{	
			_stateMachine.update(this);
		}
				
		override public function update():void
		{	
			updateState();
			
			//
			// Using atan2 for all cases causes some strange pixel sampling artifacts 
			// as a result of very small rotations. We're just working with a square 
			// at the moment to represent Grenjar, so let's just special case the 
			// purely diagonal rotation.
			// 
			
			if ((Math.abs(_direction.x) == 1.0) && (Math.abs(_direction.y) == 1.0))
			{
				angle = 45.0;
			}
			else
			{
				angle = 0.0;
			}
		}
	}
}