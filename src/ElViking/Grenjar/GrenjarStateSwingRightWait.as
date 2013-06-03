package ElViking.Grenjar 
{
	import EntityLib.State;
	
	/**
	 * Waiting for the user to either continue his attack chain, or revert
	 * back to a non-attacking state.
	 * 
	 * @author Philjo
	 */
	public class GrenjarStateSwingRightWait extends State
	{
		private var _toStanding:Boolean = false;
		private var _toSwingLeft:Boolean = false;
		private var _toWalking:Boolean = false;
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			_toWalking = false;
			_toSwingLeft = false;
			
			var grenjar:Grenjar = context as Grenjar;
			
			if (GrenjarStateUtils.grenjarAttackKey() == true) 
			{
				_toSwingLeft = true;
			} 
			else if (GrenjarStateUtils.grenjarMoveKey() == true) 
			{
				_toWalking = true;
			}
			else if (grenjar.stateMachine.currentStateDuration >= Grenjar.SWING_WAIT_DURATION_MS)
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
			else if (_toSwingLeft)
			{
				returnState = grenjar.stateMachine.getState(GrenjarState.SWINGING_LEFT_ADVANCING);
			}
			else if (_toWalking == true) 
			{
				GrenjarStateUtils.handleInput(grenjar);
				returnState = grenjar.stateMachine.getState(GrenjarState.WALKING);
			}
			
			return returnState;
		}
	}
}