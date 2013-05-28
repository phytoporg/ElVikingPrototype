package EntityLib 
{
	/**
	 * ...
	 * @author Philjo
	 */
	public class State 
	{
		//
		// Updates the internal context of the state
		//
			
		public function updateState(context:Object):void 
		{}
			
		//
		// Returns the next state.
		//
		public function getNextState(context:Object):State 
		{
			//
			// Override this method, yo.
			//
			
			return null;
		}		
}
	}