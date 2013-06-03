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
		private const SPRITE_WIDTH:int  = 20;
		private const SPRITE_HEIGHT:int = 15;
		private const HAMMER_SWING_RADIUS:int = 35; 
		
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
		// Cached states.
		//
		
		private var _swingingLeftStationaryState:State;
		private var _swingingRightAdvancingState:State;
		private var _swingingLeftAdvancingState:State;
		
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
			
			_swingingLeftStationaryState = _grenjar.stateMachine.getState(GrenjarState.SWINGING_LEFT_STATIONARY);
			_swingingLeftAdvancingState  = _grenjar.stateMachine.getState(GrenjarState.SWINGING_LEFT_ADVANCING);			
			_swingingRightAdvancingState = _grenjar.stateMachine.getState(GrenjarState.SWINGING_RIGHT_ADVANCING);
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
		
		private function isSwingingState(state:State):Boolean
		{
			return (state == _swingingLeftStationaryState) ||
			       (state == _swingingRightAdvancingState) ||
				   (state == _swingingLeftAdvancingState);
		}
		
		private function getInitialAngle(state:State):Number
		{
			var swingingState:GrenjarSuperStateSwinging = state as GrenjarSuperStateSwinging;
			return swingingState.getInitialAngle(_grenjar);
		}
		
		private function getInitialAngularVelocity(state:State):Number
		{
			var swingingState:GrenjarSuperStateSwinging = state as GrenjarSuperStateSwinging;			
			return swingingState.getInitialAngularVelocity();
		}
		
		override public function update():void
		{
			_localPosition.x = (_grenjar.x + _grenjar.width / 2) - (width / 2);
			_localPosition.y = (_grenjar.y + _grenjar.height / 2) - (height / 2);
		
			var grenjarState:State = _grenjar.stateMachine.currentState;
			var swingingState:State = _grenjar.stateMachine.getState(GrenjarState.SWINGING_LEFT_STATIONARY);
			
			//
			// If there's a state transition from non-swinging to swinging, set up the
			// initial state.
			//
			
			if ((_grenjarPrevState != grenjarState) && 
			    (isSwingingState(grenjarState) == true))
			{		 
				angle = getInitialAngle(grenjarState);
				angularVelocity = getInitialAngularVelocity(grenjarState);
			}
			
			if (isSwingingState(grenjarState) == true) 
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