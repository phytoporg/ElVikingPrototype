package ElViking.Grenjar 
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	import org.flixel.FlxG;
	
	/**
	 * State Grenjar is in when he is walking and not doing anything else.
	 * 
	 * @author Philjo
	 */
	
	internal class GrenjarStateWalking extends State
	{
		private var _toStanding:Boolean = false;
		private var _toBlocking:Boolean = false;
		private var _toSwinging:Boolean = false;
		private var _toLeaping:Boolean  = false;
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			_toBlocking = false;
			_toSwinging = false;
			_toLeaping  = false;
			
			var grenjar:Grenjar = context as Grenjar;
			
			if (GrenjarStateUtils.grenjarBlockKey() == true)
			{
				_toBlocking = true;
			}
			else if (GrenjarStateUtils.grenjarAttackKey() == true) 
			{
				_toSwinging = true;
			}
			else if (GrenjarStateUtils.grenjarLeapKey() == true)
			{
				_toLeaping = true;
			}
			else if (GrenjarStateUtils.grenjarMoveKey() == false)
			{
				_toStanding = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var stateMachine:StateMachine = grenjar.stateMachine;
			
			GrenjarStateUtils.handleInput(grenjar);
			
			var returnState:State = stateMachine.currentState;
			if (_toStanding == true) 
			{
				returnState = stateMachine.getState(GrenjarState.STANDING);
			}
			else if (_toSwinging == true) 
			{
				returnState = stateMachine.getState(GrenjarState.SWINGING_LEFT_STATIONARY);
				grenjar.velocity.x = 0;
				grenjar.velocity.y = 0;
			}
			else if (_toLeaping == true)
			{
				returnState = stateMachine.getState(GrenjarState.LEAPING);
			}
			else if (_toBlocking == true)
			{
				returnState = stateMachine.getState(GrenjarState.BLOCKING);
				grenjar.velocity.x = 0;
				grenjar.velocity.y = 0;
			}
			
			return returnState;
		}
	}
}