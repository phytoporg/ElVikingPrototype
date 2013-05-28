package ElViking.Grenjar
{
	import EntityLib.State;
	import flash.geom.Point;
	import org.flixel.*;
	
	/**
	 * 
	 * Very cool SHIELD CLASS for SHIELD TIME!!!
	 * 
	 * @author Philjo
	 */
	internal class GrenjarShield extends FlxSprite
	{
		private const SPRITE_WIDTH:int  = 20;
		private const SPRITE_HEIGHT:int = 2;
		private const SHIELD_EXTEND_DISTANCE:int = 3;
		
		//
		// Parent object is always a Grenjar instance. Flixel doesn't have any
		// transform hierarchy for scene management, so we'll have to do it
		// manually here by tracking the local position and parent object
		// (_grenjar, in this instance.)
		//
		// No need to generalize this just yet, though at some point that might
		// be a swell thing to do !
		// 
		
		private var _grenjar:Grenjar;
		
		private var _localPosition:Point;
		
		//
		// To avoid allocating a Point object every update tick.
		//
		
		private var _tempOffset:Point;
		
		public function GrenjarShield(grenjar:Grenjar) 
		{
			super(-100, -100);
			makeGraphic(SPRITE_WIDTH, SPRITE_HEIGHT);
			kill();
			
			_localPosition = new Point();
			_tempOffset    = new Point();
			
			color = FlxU.makeColor(255, 0, 0, 1.0);
			
			//
			// Parent object
			//
			
			_grenjar = grenjar;
		}
		
		private function nonBlockingUpdate():void
		{
			//
			// Grenjar's right-handed and holds his shield in his left hand.
			// In the resting position, this means Grenjar's shield hangs off
			// of the left side, so the offset is a vector orthogonal to grenjar's
			// facing direction on the left-hand-side. 
			//
			
			_tempOffset.x = _grenjar.direction.y;
			_tempOffset.y = -_grenjar.direction.x;
			_tempOffset.normalize((_grenjar.width / 2) + (SPRITE_HEIGHT / 2));
			
			x = _localPosition.x + _tempOffset.x;
			y = _localPosition.y + _tempOffset.y;
			angle = (360 / (2 * Math.PI)) * 
			         Math.atan2(_grenjar.direction.y, _grenjar.direction.x);
		}
		
		private function blockingUpdate():void
		{
			//
			// Grenjar just sticks his shield flat out in front of him when blocking.
			// Pushing the shield out a little bit to give a clear visual distinction
			// between blocking and non-blocking states (hence SHIELD_EXTEND_DISTANCE).
			//
			
			_tempOffset.x = _grenjar.direction.x;
			_tempOffset.y = _grenjar.direction.y;
			_tempOffset.normalize(
				(_grenjar.height / 2) + 
				(SPRITE_HEIGHT / 2) + 
				SHIELD_EXTEND_DISTANCE
				);
			
			x = _localPosition.x + _tempOffset.x;
			y = _localPosition.y + _tempOffset.y;
			angle = (360 / (2 * Math.PI)) * 
			         Math.atan2(_grenjar.direction.y, _grenjar.direction.x) +
					 90;
		}
		
		override public function update():void
		{
			//
			// We'll make the reference point the center of both objects
			// for the following calculations (by default, flixel uses the
			// upper-left corner).
			//
			
			_localPosition.x = (_grenjar.x + _grenjar.width / 2) - (width / 2);
			_localPosition.y = (_grenjar.y + _grenjar.height / 2) - (height / 2);
			
			var blockingState:State = _grenjar.stateMachine.getState(GrenjarState.BLOCKING);
			if (_grenjar.stateMachine.currentState == blockingState) 
			{
				blockingUpdate();
			}
			else
			{
				nonBlockingUpdate();		
			}
		}
	}
}