package ElViking.Grenjar 
{
	import EntityLib.State;
	import flash.geom.Point;
	/**
	 * Grenjar's leaping forward with WEPON.
	 * 
	 * @author Philjo
	 */
	public class GrenjarStateLeaping extends State
	{

		private var _toRecovery:Boolean = false;
		override public function updateState(context:Object):void
		{
			_toRecovery = false;
			
			var grenjar:Grenjar = context as Grenjar;
			if (grenjar.stateMachine.currentStateDuration >= Grenjar.LEAP_DURATION_MS) 
			{
				_toRecovery = true;
			}
		}
		
		private function updateGrenjarLeapScale(grenjar:Grenjar):void
		{
			var time:Number = grenjar.stateMachine.currentStateDuration;
			var tMax:Number = Grenjar.LEAP_DURATION_MS;
			var a:Number = (Grenjar.LEAP_SCALE_MAX - 1) / ((tMax * tMax) * -0.25);
			var b:Number = (-a * tMax);
			var c:Number = 1;
			
			var scale:Number = a * (time * time) + b * time + c;
			grenjar.scale.x = scale;
			grenjar.scale.y = scale;
		}
		
		private var _tempPoint:Point = new Point();
		override public function getNextState(context:Object):State
		{
			var grenjar:Grenjar = context as Grenjar;
			var returnState:State = grenjar.stateMachine.currentState;
			
			if (_toRecovery == true) 
			{
				grenjar.scale.x = 1.0;
				grenjar.scale.y = 1.0;
				
				grenjar.velocity.x = 0.0;
				grenjar.velocity.y = 0.0;
				returnState = grenjar.stateMachine.getState(GrenjarState.LEAP_RECOVERY);
			}
			else 
			{
				updateGrenjarLeapScale(grenjar);
				_tempPoint.x = grenjar.direction.x;
				_tempPoint.y = grenjar.direction.y;
				_tempPoint.normalize(Grenjar.LEAP_SPEED);
				
				grenjar.velocity.x = _tempPoint.x;
				grenjar.velocity.y = _tempPoint.y;
			}
			
			return returnState;
		}
	}
}