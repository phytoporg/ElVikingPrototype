package ElViking.Grenjar 
{
	import EntityLib.State;
	import flash.geom.Point;
	import org.flixel.*;
	
	/**
	 * Swing dat hammer, kill da enemies.
	 * 
	 * @author Philjo
	 */
	public class GrenjarHammer extends FlxSprite
	{
		private const SPRITE_WIDTH:int  = 100;
		private const SPRITE_HEIGHT:int = 100;
		private const HAMMER_SWING_RADIUS:int = 30;
		
		private const SWING_BEGIN_ANGLE:Number = 30;
		private const SWING_END_ANGLE:Number = 120; 
		
		//
		// Parent object
		//
		
		private var _grenjar:Grenjar;
		private var _localPosition:Point;
		
		//
		// To avoid allocating a Point object every update tick. Not
		// sure if we'll need this just yet, but it's LIKELY!!!
		//
		
		private var _tempOffset:Point;
		
		//
		// Tracks the current rotation angle across update cycles.
		//
		
		private var _currentRotationAngle:Number;
		public function GrenjarHammer(grenjar:Grenjar) 
		{
			super( -100, -100);
			makeGraphic(SPRITE_WIDTH, SPRITE_HEIGHT);
			kill();
			
			_localPosition = new Point();
			_tempOffset    = new Point();
			
			color = FlxG.WHITE;
			
			_grenjar = grenjar;
			_currentRotationAngle = 0;
		}
	
		private function swingingUpdate(maxDuration:int, duration:int):void
		{
			var angleDelta:Number = (SWING_BEGIN_ANGLE - SWING_END_ANGLE) / maxDuration;
			_currentRotationAngle += angleDelta;
			
			angle = _currentRotationAngle;
		}
	
		override public function update():void
		{
			//
			// This needs some serious refactoring AHHH
			//
			
			_localPosition.x = (_grenjar.x + _grenjar.width / 2) - (width / 2);
			_localPosition.y = (_grenjar.y + _grenjar.height / 2) - (height / 2);
		
			var swingingState:State = _grenjar.stateMachine.getState(GrenjarState.SWINGING);
			if (_grenjar.stateMachine.currentState == swingingState) 
			{
				var theSwingingState:GrenjarStateSwinging = swingingState as GrenjarStateSwinging;
				
				visible = true;
				swingingUpdate(
					theSwingingState.swingDuration,
					_grenjar.stateMachine.currentStateDuration
					);
			}
			else
			{
				visible = false;
				_currentRotationAngle = 0;
			}
						
			x = _localPosition.x;
			y = _localPosition.y;
		}
	}
}