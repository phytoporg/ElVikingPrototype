package ElViking.Grenjar 
{
	import EntityLib.State;
	
	/**
	 * Recovery state after swinging left!
	 * 
	 * @author Philjo
	 */
	
	public class GrenjarStateSwingLeftRecovery extends State
	{
		private var _toWaiting:Boolean = false;
		
		override public function updateState(context:Object):void
		{
			_toWaiting = false;
			
			var grenjar:Grenjar = context as Grenjar;			
			if (grenjar.stateMachine.currentStateDuration >= Grenjar.SWING_RECOVERY_DURATION_MS) 
			{
				_toWaiting = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var returnState:State = grenjar.stateMachine.currentState;
			if (_toWaiting == true) 
			{
				returnState = grenjar.stateMachine.getState(GrenjarState.SWINGING_LEFT_WAITING);
			}
			
			return returnState;
		}
	}
}