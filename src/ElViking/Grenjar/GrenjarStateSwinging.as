package ElViking.Grenjar 
{
	import EntityLib.State;
	import EntityLib.StateMachine;
	/**
	 * The "Grenjar is swinging his hammer" state
	 * 
	 * @author Philjo
	 */
	public class GrenjarStateSwinging extends State
	{	
		private var _toStanding:Boolean;
		
		//
		// Duration is measured in ticks (update calls)
		//
		
		private var _swingDuration:int;
		public function get swingDuration():int
		{
			return _swingDuration;
		}
		
		public function GrenjarStateSwinging(swingDuration:int)
		{
			_swingDuration = swingDuration;
			_toStanding = false;
		}
		
		override public function updateState(context:Object):void
		{
			_toStanding = false;
			
			var grenjar:Grenjar = context as Grenjar;
			if (grenjar.stateMachine.currentStateDuration >= _swingDuration) 
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
		
			return returnState;
		}
	}
}