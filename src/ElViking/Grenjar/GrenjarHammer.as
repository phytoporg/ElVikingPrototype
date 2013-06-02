package ElViking.Grenjar 
{
	import EntityLib.State;
	import flash.geom.Point;
	import org.flixel.*;
	
	/**
	 * Swing dat hammer, kill da enemies.
	 * 
	 * @author Philjo
	 */
	public class GrenjarHammer extends FlxSprite
	{
		private const SPRITE_WIDTH:int  = 25;
		private const SPRITE_HEIGHT:int = 20;
		private const HAMMER_SWING_RADIUS:int = 35;
		
		private const SWING_BEGIN_ANGLE:Number = 0;
		private const SWING_END_ANGLE:Number = 135; 
		
		//
		// Parent object transform management.
		//
		
		private var _grenjar:Grenjar;
		private var _localPosition:Point;
		
		private var _grenjarPrevState:State;
		
		//
		// To avoid allocating a Point object every update tick. Not
		// sure if we'll need this just yet, but it's LIKELY!!!
		//
		
		private var _tempOffset:Point;
		
		//
		// Tracks the current rotation angle across update cycles.
		//
		
		private var _currentRotationAngle:Number;
		public function GrenjarHammer(grenjar:Grenjar) 
		{
			super( -100, -100);
			
			//
			// Sprite is flipped on its side to simplify rotation logic, 
			// hence the swapped height and width here.
			//
			
			makeGraphic(SPRITE_HEIGHT, SPRITE_WIDTH);
			kill();
			
			_localPosition = new Point();
			_tempOffset    = new Point();
			
			color = FlxG.WHITE;
			
			_grenjar = grenjar;
			_grenjarPrevState = grenjar.stateMachine.currentState;
			_currentRotationAngle = 0;
		}
	
		private function swingingUpdate():void
		{				
			var degToRad:Number = (Math.PI) / 180; // Is there really no helper function in FlxU for this?
			
			// 
			// Negate x-offset because we're swinging from right to left.
			//
			
			_tempOffset.x = HAMMER_SWING_RADIUS * Math.cos(-angle * degToRad);
			_tempOffset.y = -HAMMER_SWING_RADIUS * Math.sin(-angle * degToRad);
		}
	
		override public function update():void
		{
			_localPosition.x = (_grenjar.x + _grenjar.width / 2) - (width / 2);
			_localPosition.y = (_grenjar.y + _grenjar.height / 2) - (height / 2);
		
			var grenjarState:State = _grenjar.stateMachine.currentState;
			var swingingState:State = _grenjar.stateMachine.getState(GrenjarState.SWINGING);
			
			//
			// If there's a state transition from non-swinging to swinging, set up the
			// initial state.
			//
			
			if ((_grenjarPrevState != grenjarState) && 
			    (grenjarState == swingingState)) 
			{
				var degToRad:Number = (Math.PI) / 180;
				var radToDeg:Number = 1 / degToRad;
				var grenjarAngle:Number = 
					radToDeg * Math.atan2(
								//
								// Negate y-axis because screen coordinates lol
								//
								 -_grenjar.direction.y,
								 
								//
								// Don't know why I needed to negate this, ugh. This
								// all needs some serious refactoring.
								//
								-_grenjar.direction.x 
								 );
								 
				//
				// Subtract 90 because we're interested in a rotation
				// angle offset to the right of the direction grenjar
				// is facing by 90 degrees.
				//
				
				angle = (grenjarAngle - SWING_BEGIN_ANGLE - 90); 
				
				//
				// Not sure what's going on, but the rotation seems to be clockwise by
				// default, which is definitely counterintuitive. Will have to investigate
				// later, since I've wasted enough time on that. D: Negate the angular
				// velocity here and account for the negative angle in updateSwinging().
				//
				var qualifiedSwingState:GrenjarStateSwinging = swingingState as GrenjarStateSwinging;
				var swingDurationSeconds:Number = (qualifiedSwingState.swingDurationMs / 1000.0);
				angularVelocity = -((SWING_END_ANGLE - SWING_BEGIN_ANGLE) / swingDurationSeconds);
			}
			
			if (grenjarState == swingingState) 
			{
				visible = true;
				swingingUpdate();
			}
			else
			{
				visible = false;
				angle = 0;
				_currentRotationAngle = 0;
			}
						
			x = _localPosition.x + _tempOffset.x;
			y = _localPosition.y + _tempOffset.y;
			
			_grenjarPrevState = grenjarState;
		}
	}
}