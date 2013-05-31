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
		
		private const WALK_SPEED:int = 150;
		private const SPRITE_HEIGHT:int = 25;
		private const SPRITE_WIDTH:int  = 25;
		
		private const GRENJAR_SWING_DURATION:int = 15;
		
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
			stateDictionary[GrenjarState.SWINGING] = new GrenjarStateSwinging(GRENJAR_SWING_DURATION);
			
			_stateMachine = 
				new StateMachine(
					GrenjarState.STANDING, 
					stateDictionary
					);
		}
		
		private function BoundValue(value:Number, lowerBound:Number, upperBound:Number):Number
		{			
			if (value < lowerBound)
			{
				return lowerBound;
			}
			else if (value > upperBound)
			{
				return upperBound;
			}
			
			return value;
		}
		
		private function handleInput():void
		{	
			velocity.x = 0.0;
			velocity.y = 0.0;		
			
			if (FlxG.keys.LEFT)
			{
				velocity.x = -WALK_SPEED;
				_direction.x = -1.0;
			}
			else if (FlxG.keys.RIGHT)
			{
				velocity.x = WALK_SPEED;
				_direction.x = 1.0;
			}
			else if (FlxG.keys.UP || FlxG.keys.DOWN)
			{
				//
				// Persist the x component of the direction unless we're moving
				// along the y-axis.
				//
				
				_direction.x = 0.0;
			}
			
			if (FlxG.keys.UP)
			{
				velocity.y = -WALK_SPEED;
				_direction.y = -1.0;
			} 
			else if (FlxG.keys.DOWN)
			{
				velocity.y = WALK_SPEED;
				_direction.y = 1.0;
			}
			else if (FlxG.keys.LEFT || FlxG.keys.RIGHT)
			{
				//
				// Persist the y component of the direction unless we're moving along
				// the x-axis.
				//
				
				_direction.y = 0.0;
			}
			
			x = BoundValue(x, 0, FlxG.width - width);
			y = BoundValue(y, 0, FlxG.height - height);
		}
		
		private function updateState():void
		{	
			handleInput();
			
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