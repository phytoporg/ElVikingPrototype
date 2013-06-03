package ElViking.Grenjar 
{
	import EntityLib.State;
	
	/**
	 * This state follows the recovery of a left swing, and represents the
	 * time during which the player can press attack to chain into a right swing
	 * or carry out any other action and nullify the chain.
	 * 
	 * @author Philjo
	 */
	public class GrenjarStateSwingLeftWait extends State
	{	
		private var _toStanding:Boolean = false;
		private var _toSwingRight:Boolean = false;
		private var _toWalking:Boolean = false;
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			_toWalking = false;
			_toSwingRight = false;
			
			var grenjar:Grenjar = context as Grenjar;
			
			if (GrenjarStateUtils.grenjarAttackKey() == true) 
			{
				_toSwingRight = true;
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
			else if (_toSwingRight)
			{
				returnState = grenjar.stateMachine.getState(GrenjarState.SWINGING_RIGHT_ADVANCING);
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