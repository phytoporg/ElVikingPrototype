package ElViking.Grenjar
{
	import org.flixel.*
	
	/**
	 * Manages all of Grenjar's components (body, shield, weapon, etc).
	 * 
	 * @author Philjo
	 */
	public class GrenjarGroup extends FlxGroup
	{
		private var _body:Grenjar;
		private var _shield:GrenjarShield;
		
		public function GrenjarGroup()
		{
			super();
			_body = new Grenjar();
		    _body.x = 100;
			_body.y = 100;
			_body.revive();
			add(_body);
						
			_shield = new GrenjarShield(_body);
			_shield.revive();
			add(_shield);
		}
		
		override public function preUpdate():void
		{
			//
			// Account for draw order before updating child components.
			//
			
			sort("y", ASCENDING);
		}
	}

}