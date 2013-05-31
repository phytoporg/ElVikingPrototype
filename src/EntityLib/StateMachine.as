package EntityLib 
{
	import flash.utils.Dictionary;
	
	/**
	 * A state container which also drives the state machine forward.
	 * 
	 * @author Philjo
	 */
	public class StateMachine 
	{
		//
		// Duration measured in ticks (update calls).
		//
		
		protected var _currentStateDuration:int;
		public function get currentStateDuration():int
		{
			return _currentStateDuration;
		}
			
		protected var _currentState:State;
		public function get currentState():State
		{
			return _currentState;
		}
		
		protected var _stateDictionary:Dictionary;
		
		public function StateMachine(
			currentStateName:String, 
			initialStateDictionary:Dictionary):void
		{
			_stateDictionary = initialStateDictionary;
			
			//
			// TODO:
			// 
			// What's the behavior of an AS3 dictionary in the instance where
			// currentStateName is an invalid key? D: Official docs are seriously
			// lacking, or maybe I can't read.
			//
			
			_currentState = _stateDictionary[currentStateName];
			_currentStateDuration = 0;
		}
		
		//
		// Retrieves a state by name, or null if no such state exists by 
		// the name passed in.
		//
		
		public function getState(stateName:String):State
		{
			return _stateDictionary[stateName];
		}
		
		//
		// Adds a new state; replaces any existing state if there is a name
		// collision.
		//
		
		public function addState(stateName:String, state:State):void
		{
			_stateDictionary[stateName] = state;
		}
		
		//
		// Advances the state machine by a single tick.
		//
		
		public function update(context:Object):void
		{
			if (_currentState == null)
			{
				return;
			}
			
			var tempState:State = _currentState;
			
			_currentState.updateState(context);
			_currentState = _currentState.getNextState(context);
			
			if (tempState != _currentState) 
			{
				_currentStateDuration = 0;
			}
			else 
			{
				_currentStateDuration++;
			}
		}
	}

}