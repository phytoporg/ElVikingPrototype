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
		private var _toStanding:Boolean;
		private var _toBlocking:Boolean;
		
		public function GrenjarStateWalking():void
		{
			_toStanding = false;
			_toBlocking = false;
		}
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			_toBlocking = false;
			
			var grenjar:Grenjar = context as Grenjar;
			
			if (FlxG.keys.Z == true)
			{
				_toBlocking = true;
			}
			else if ((grenjar.velocity.x == 0) && (grenjar.velocity.y == 0))
			{
				_toStanding = true;
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