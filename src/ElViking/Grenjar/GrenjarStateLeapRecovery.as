package ElViking.Grenjar 
{
	import EntityLib.State;
	
	/**
	 * Grenjar's in leap recovery and can't do NOTHIN'
	 * 
	 * @author Philjo
	 */
	
	public class GrenjarStateLeapRecovery extends State
	{
		private var _toStanding:Boolean = false;
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			
			var grenjar:Grenjar = context as Grenjar;
			if (grenjar.stateMachine.currentStateDuration >= Grenjar.LEAP_RECOVERY_MS) 
			{
				_toStanding = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var returnState:State = grenjar.stateMachine.currentState;
			
			if (_toStanding == true) 
			{
				returnState = grenjar.stateMachine.getState(GrenjarState.STANDING);
			}
			
			return returnState;
		}	
	}
}