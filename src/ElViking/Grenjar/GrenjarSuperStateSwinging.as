package ElViking.Grenjar 
{
	import EntityLib.State;
	/**
	 * An "abstract" class which represents a state in which Grenjar
	 * is swinging his weapon in some form or another.
	 * 
	 * @author Philjo
	 */
	public class GrenjarSuperStateSwinging extends State
	{
		//
		// Up to the child states to implement updateState
		// and getNextState
		//
		
		//
		// Override these functions (consider them pure virtual)
		//
		
		public function get swingDurationMs():int
		{
			return 0;
		}
		
		public function getInitialAngle(grenjar:Grenjar):Number
		{
			return 0;
		}
		
		public function getInitialAngularVelocity():Number
		{
			return 0;
		}
	}
}