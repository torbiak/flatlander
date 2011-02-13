package	sprites
{
	import constants.*;
	
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
        public var heldMaterial:HeldMaterial;
		[Embed(source="../../assets/player.png")]
		public static var PlayerImage:Class;

		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(PlayerImage, false, false, 16, 16);
			
			// Save an instance of the PlayState to help with collision detection and movement
			state = FlxG.state as PlayState;
			maxVelocity = new FlxPoint(120, 120);
            width = 12;
            height = 12;
            offset = new FlxPoint(2, 2);
            heldMaterial = new HeldMaterial(x, y, Materials.NOTHING);
            state.add(heldMaterial);
		}

		override public function update():void
		{
			var mul:uint = 4;
			acceleration.x = 0;
			acceleration.y = 0;
			drag.x = maxVelocity.x * (mul + 1);
			drag.y = maxVelocity.y * (mul + 1);
			if (state.gameState == GameStates.PLAYING)
			{
                var isMoving:Boolean = false;
				if (FlxG.keys.pressed("LEFT")){
					acceleration.x = -maxVelocity.x * mul;
                    frame = 2;
                    facing = LEFT;
                    isMoving = true;
				}
				if (FlxG.keys.pressed("RIGHT")){
					acceleration.x = maxVelocity.x * mul;
                    frame = 1;
                    facing = RIGHT;
                    isMoving = true;
				}
				if (FlxG.keys.pressed("UP")){
					acceleration.y = -maxVelocity.y * mul;
                    frame = 3;
                    facing = UP;
                    isMoving = true;
				}
				if (FlxG.keys.pressed("DOWN")){
					acceleration.y = maxVelocity.y * mul;
                    frame = 0;
                    facing = DOWN;
                    isMoving = true;
				}
				if (FlxG.keys.justPressed("Z")){
                    if (heldMaterial.kind == Materials.NOTHING){
                        pickup();
                    } else {
                        drop();
                    }
				}
			}
			//Default object physics update
			super.update();
		}

        public function pickup():void
        {
            if (heldMaterial.kind == Materials.NOTHING)
			{
				heldMaterial.tileCoords = state.tileCoordsPlayerIsFacing();
                heldMaterial.kind = state.pickup();
            }
        }

        public function drop():void
        {
            if (heldMaterial.kind != Materials.NOTHING){
                if (state.drop(heldMaterial.kind) != Materials.NOTHING) {
					heldMaterial.tileCoords = state.tileCoordsPlayerIsFacing();
                    heldMaterial.kind = Materials.NOTHING;
                    return;
                }
            }
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
