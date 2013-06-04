package ElViking.Grenjar 
{
	import EntityLib.State;
	
	/**
	 * Grenjar's gettin' ready to LEAP!!
	 * @author Philjo
	 */
	
	public class GrenjarStateStartingLeap extends State
	{
		private var _toLeaping:Boolean = false;
		
		override public function updateState(context:Object):void
		{
			_toLeaping = false
			
			var grenjar:Grenjar = context as Grenjar;
			if (grenjar.stateMachine.currentStateDuration >= Grenjar.LEAP_START_DURATION_MS)
			{
				_toLeaping = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var returnState:State = grenjar.stateMachine.currentState;
			
			if (_toLeaping == true) 
			{
				returnState = grenjar.stateMachine.getState(GrenjarState.LEAPING);
			}
			
			return returnState;
		}
	}
}