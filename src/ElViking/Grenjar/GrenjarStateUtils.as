package ElViking.Grenjar 
{
	import org.flixel.FlxG;
	
	/**
	 * Some utilities for commonly invoked functionality within Grenjar's
	 * state machine.
	 * 
	 * @author Philjo
	 */
	
	public class GrenjarStateUtils 
	{
		public static function grenjarMoveKey():Boolean
		{
			return (
				    FlxG.keys.LEFT  || 
			        FlxG.keys.RIGHT || 
					FlxG.keys.DOWN  || 
					FlxG.keys.UP
					);
		}
		
		public static function grenjarBlockKey():Boolean
		{
			return FlxG.keys.Z;
		}
		
		public static function grenjarAttackKey():Boolean
		{
			return FlxG.keys.X;
		}
		
		public static function grenjarLeapKey():Boolean
		{
			return FlxG.keys.C;
		}
		
		public static function handleInput(grenjar:Grenjar):void
		{	
			grenjar.velocity.x = 0.0;
			grenjar.velocity.y = 0.0;		
			
			if (FlxG.keys.LEFT)
			{
				grenjar.velocity.x = -Grenjar.WALK_SPEED;
				grenjar.direction.x = -1.0;
			}
			else if (FlxG.keys.RIGHT)
			{
				grenjar.velocity.x = Grenjar.WALK_SPEED;
				grenjar.direction.x = 1.0;
			}
			else if (FlxG.keys.UP || FlxG.keys.DOWN)
			{
				//
				// Persist the x component of the direction unless we're moving
				// along the y-axis.
				//
				
				grenjar.direction.x = 0.0;
			}
			
			if (FlxG.keys.UP)
			{
				grenjar.velocity.y = -Grenjar.WALK_SPEED;
				grenjar.direction.y = -1.0;
			} 
			else if (FlxG.keys.DOWN)
			{
				grenjar.velocity.y = Grenjar.WALK_SPEED;
				grenjar.direction.y = 1.0;
			}
			else if (FlxG.keys.LEFT || FlxG.keys.RIGHT)
			{
				//
				// Persist the y component of the direction unless we're moving along
				// the x-axis.
				//
				
				grenjar.direction.y = 0.0;
			}
		}
	}
}