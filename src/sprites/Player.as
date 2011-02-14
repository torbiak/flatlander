package	sprites
{
	import constants.*;
	
	import org.flixel.*;
	
	import states.PlayState;
	
	public class Player extends FlxSprite
	{
		private const animationFPS:int = 7;
		
		
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
		[Embed(source="../../assets/playeAltr.png")]
		public static var PlayerImage:Class;

		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(PlayerImage, false, false, 16, 16);
			
			// Save an instance of the PlayState to help with collision detection and movement
			state = FlxG.state as PlayState;
			maxVelocity = new FlxPoint(60, 60);
            width = 12;
            height = 12;
            offset = new FlxPoint(2, 2);
            heldMaterial = new HeldMaterial(x, y, Materials.NOTHING);
            state.add(heldMaterial);
			addAnimation("DOWN", [0, 1, 0, 2], animationFPS, true);
			addAnimation("RIGHT", [3, 4, 3, 5], animationFPS, true);
			addAnimation("LEFT", [6, 7, 6, 8], animationFPS, true);
			addAnimation("UP", [9, 10, 9, 11], animationFPS, true);
		}

		override public function update():void
		{
			if (velocity.x == 0 && velocity.y == 0) {
				var stillFrames:Array = [6,3,9,0];
				frame = stillFrames[facing];
			}
			
			var mul:uint = 4;
			acceleration.x = 0;
			acceleration.y = 0;
			var animationOverride:Boolean = FlxG.keys.pressed("UP") || FlxG.keys.pressed("DOWN");
			drag.x = maxVelocity.x * (mul + 1);
			drag.y = maxVelocity.y * (mul + 1);
			if (state.gameState == GameStates.PLAYING)
			{
                var isMoving:Boolean = false;
				if (FlxG.keys.pressed("LEFT")){
					acceleration.x = -maxVelocity.x * mul;
					if(!animationOverride) play("LEFT");
                    facing = LEFT;
                    isMoving = true;
				} else
				if (FlxG.keys.pressed("RIGHT")){
					acceleration.x = maxVelocity.x * mul;
					if(!animationOverride) play("RIGHT");
                    facing = RIGHT;
                    isMoving = true;
				} 
				if (FlxG.keys.pressed("UP")){
					acceleration.y = -maxVelocity.y * mul;
					play("UP");
                    facing = UP;
                    isMoving = true;
				} else
				if (FlxG.keys.pressed("DOWN")){
					acceleration.y = maxVelocity.y * mul;
					play("DOWN");
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
