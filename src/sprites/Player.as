package	sprites
{
	import constants.GameStates;
	
	import org.flixel.*;
	
	import states.PlayState;
	
	public class Player extends FlxSprite
	{
		private var maxMoveX:int;
		private var maxMoveY:int;
		private var targetX:Number;
		private var targetY:Number;
		private var moveX:int = 1;
		private var moveY:Number = 1;
		private var animationFrames:int = 1;
		private var state:PlayState;
		public var isMoving:Boolean;
		[Embed(source="../../assets/player.png")]
		public static var PlayerImage:Class;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(PlayerImage, false, false, 16, 16);
			
			// Save an instance of the PlayState to help with collision detection and movement
			state = FlxG.state as PlayState;
			maxVelocity = new FlxPoint(300, 300);
		}
		
		/**
		 * The main Frog update loop. This handles keyboard movement, collision and flagging id moving.
		 */
		override public function update():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			velocity.x = velocity.x * 0.95;
			velocity.y = velocity.y * 0.95;
			var speed:uint = 1000;
			if (state.gameState == GameStates.PLAYING)
			{
				if (FlxG.keys.pressed("LEFT")){
					acceleration.x -= speed;
					frame = 2;
				}
				if (FlxG.keys.pressed("RIGHT")){
					acceleration.x += speed;
					frame = 1;
				}
				if (FlxG.keys.pressed("UP")){
					acceleration.y -= speed;
					frame = 3;
				}
				if (FlxG.keys.pressed("DOWN")){
					acceleration.y += speed;
					frame = 0;
				}
			}
			//Default object physics update
			super.update();
		}
		
		/**
		 * Simply plays the death animation
		 */
		public function death():void
		{
			
		}
		
		/**
		 * This resets values of the Frog instance.
		 */
		public function restart():void
		{
			
		}
		
		/**
		 * This handles moving the Frog in the same direction as any instance it is resting on.
		 *
		 * @param speed the speed in pixels the Frog should move
		 * @param facing the direction the frog will float in
		 */
		public function float(speed:int, facing:uint):void
		{
			
		}
	}
}