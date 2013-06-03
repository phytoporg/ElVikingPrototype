package ElViking.Grenjar 
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	import org.flixel.FlxG;
	
	/**
	 * The "Grenjar is standing still" state
	 * 
	 * @author Philjo
	 */
	
	internal class GrenjarStateStanding extends State
	{
		private var _toWalking:Boolean;
		private var _toBlocking:Boolean;
		private var _toSwinging:Boolean;
		
		override public function GrenjarStateStanding():void
		{
			_toWalking = false;
			_toBlocking = false;
			_toSwinging = false;
		}
		
		override public function updateState(context:Object):void
		{
			_toWalking = false;
			_toBlocking = false;
			_toSwinging = false;
			
			var grenjar:Grenjar = context as Grenjar;
			
			if (GrenjarStateUtils.grenjarBlockKey() == true) 
			{
				_toBlocking = true;
			}
			else if (GrenjarStateUtils.grenjarAttackKey() == true)
			{
				_toSwinging = true;
			}
			else if (GrenjarStateUtils.grenjarMoveKey() == true)
			{
				_toWalking = true;
			}
		}
		
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var stateMachine:StateMachine = grenjar.stateMachine;
			
			var returnState:State = stateMachine.currentState;
			if (_toBlocking == true) 
			{
				grenjar.velocity.x = 0;
				grenjar.velocity.y = 0;
				returnState = stateMachine.getState(GrenjarState.BLOCKING);
			}
			else if (_toSwinging == true) 
			{
				grenjar.velocity.x = 0;
				grenjar.velocity.y = 0;
				returnState = stateMachine.getState(GrenjarState.SWINGING_LEFT_STATIONARY);
			}
			else if (_toWalking == true)
			{
				returnState = stateMachine.getState(GrenjarState.WALKING);
			}
			
			return returnState;
		}
	}
}