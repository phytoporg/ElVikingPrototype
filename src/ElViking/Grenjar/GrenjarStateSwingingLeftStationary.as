package ElViking.Grenjar 
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	/**
	 * The "Grenjar is swinging his hammer" state
	 * 
	 * @author Philjo
	 */
	public class GrenjarStateSwingingLeftStationary extends GrenjarSuperStateSwinging
	{	
		private var _toStanding:Boolean;
		private var _toNextSwing:Boolean;
		
		public function GrenjarStateSwingingLeftStationary()
		{
			_toStanding = false;
			_toNextSwing = false;
		}
		
		private var _pressedAttack:Boolean = false;
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			_toNextSwing = false;
			
			var grenjar:Grenjar = context as Grenjar;
			var timeOut:Boolean = 
				grenjar.stateMachine.currentStateDuration >= 
				Grenjar.GRENJAR_SWING_DURATION_MS;
			if (timeOut && (_pressedAttack == false)) 
			{
				_toStanding = true;
			}
			else if (timeOut && (_pressedAttack == true))
			{
				_toNextSwing = true;
			}
			else if ((GrenjarStateUtils.grenjarAttackKey() == true) && 
			         (grenjar.stateMachine.currentStateDuration >= 100)) 
			{
				_pressedAttack = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var stateMachine:StateMachine = grenjar.stateMachine;
			
			var returnState:State = stateMachine.currentState;
			if (_toStanding == true)
			{
				returnState = stateMachine.getState(GrenjarState.STANDING);
			}
			else if (_toNextSwing == true) 
			{
				returnState = stateMachine.getState(GrenjarState.SWINGING_RIGHT_ADVANCING);
			}
			
			if (returnState != stateMachine.currentState) 
			{
				//
				// Restore the default state for next transition here.
				//
				
				_toStanding  = false;
				_toNextSwing = false;
				_pressedAttack = false;
			}
			
			return returnState;
		}
		
		override public function getInitialAngle(grenjar:Grenjar):Number
		{
			var degToRad:Number = (Math.PI) / 180;
			var radToDeg:Number = 1 / degToRad;
			var grenjarAngle:Number = 
				radToDeg * Math.atan2(
							//
							// Negate y-axis because screen coordinates lol
							//
							 -grenjar.direction.y,
								 
							//
							// Don't know why I needed to negate this, ugh. This
							// all needs some serious debugging.
							//
							-grenjar.direction.x 
							 );
							 
			return grenjarAngle - Grenjar.SWING_BEGIN_ANGLE - 90; 
		}
		
		override public function getInitialAngularVelocity():Number
		{
			var swingDurationSeconds = Grenjar.GRENJAR_SWING_DURATION_MS / 1000.0;
			return -((Grenjar.SWING_END_ANGLE - Grenjar.SWING_BEGIN_ANGLE) / swingDurationSeconds);
		}
	}
}