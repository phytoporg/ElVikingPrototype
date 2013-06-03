package ElViking.Grenjar 
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	/**
	 * The "Grenjar is swinging his hammer from right to left" state
	 * 
	 * @author Philjo
	 */
	public class GrenjarStateSwingingLeftStationary extends GrenjarSuperStateSwinging
	{	
		private var _toRecovery:Boolean = false;
		
		override public function updateState(context:Object):void
		{
			_toRecovery = false;
			
			var grenjar:Grenjar = context as Grenjar;
			var timeOut:Boolean = 
				grenjar.stateMachine.currentStateDuration >= 
				Grenjar.SWING_DURATION_MS;
			if (timeOut == true) 
			{
				_toRecovery = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var stateMachine:StateMachine = grenjar.stateMachine;
			
			var returnState:State = stateMachine.currentState;
			if (_toRecovery == true)
			{
				returnState = stateMachine.getState(GrenjarState.SWINGING_LEFT_RECOVERY);
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
			var swingDurationSeconds:Number = Grenjar.SWING_DURATION_MS / 1000.0;
			return -((Grenjar.SWING_END_ANGLE - Grenjar.SWING_BEGIN_ANGLE) / swingDurationSeconds);
		}
	}
}