package ElViking.Grenjar 
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	import org.flixel.FlxG;
	
	/**
	 * State that Grenjar is in when he's holding up his shield in a defensive
	 * position.
	 * 
	 * @author Philjo
	 */
	internal class GrenjarStateBlocking extends State
	{
		private var _toStanding:Boolean;
		private var _toWalking:Boolean;
		
		public function GrenjarStateBlocking():void
		{
			_toStanding = false;
			_toWalking = false;
		}
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			_toWalking = false;
			
			var grenjar:Grenjar = context as Grenjar;
			
			if ((FlxG.keys.Z == false) && 
			    ((grenjar.velocity.x == 0) && (grenjar.velocity.y == 0)))
			{
				_toStanding = true;
			}
			else if ((FlxG.keys.Z == false) &&
			         ((grenjar.velocity.x != 0) || (grenjar.velocity.y != 0)))
			{
				_toWalking = true;
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
			else if (_toWalking == true)
			{
				returnState = stateMachine.getState(GrenjarState.WALKING);
			}
			else 
			{
				grenjar.velocity.x = 0;
				grenjar.velocity.y = 0;
			}
			
			return returnState;
		}
	}
}