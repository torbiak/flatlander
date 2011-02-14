package	sprites
{
	import constants.*;
	
	import org.flixel.*;
	
	import states.PlayState;

	public class HeldMaterial extends FlxSprite
	{
		private static const PICKUP:int = 0;
		private static const DROP:int = 1;
		
		public static const OFFSET_X:int = -2;
		public static const OFFSET_Y:int = -17;
		[Embed(source="../../assets/icons.png")]
		public static var Tiles:Class;
		private var _kind:int;
		public var state:PlayState;
		public var _tileCoords:FlxPoint = new FlxPoint;
		private var action:int;
		private var inposition:Boolean = false;
		public var emitter:FlxEmitter;

		public function HeldMaterial(X:Number, Y:Number, materialKind:uint)
		{
			super(X, Y);
			_kind = materialKind;
			state = FlxG.state as PlayState;
			loadGraphic(Tiles, false, false, state.TILE_SIZE_X, state.TILE_SIZE_Y);
			frame = _kind;
			exists = false;
		}

		override public function update():void
		{
			if (state.gameState == GameStates.PLAYING)
			{
				var movementFactor:uint = 5;
				if (action == PICKUP)
				{
					var playerx:uint = state.player.x + OFFSET_X;
					var playery:uint = state.player.y + OFFSET_Y;
					if (inposition)
					{
						x = state.player.x + OFFSET_X;
						y = state.player.y + OFFSET_Y;
					}
					else if (x < playerx + movementFactor && x > playerx - movementFactor || 
							 y < playery + movementFactor && y > playery - movementFactor)
					{
						inposition = true;
					}
					else
					{
						if (x < playerx) {
							x+=movementFactor;
						}
						if (x > playerx) {
							x-=movementFactor;
						}
						if (y < playery) {
							y+=movementFactor;
						}
						if (y > playery) {
							y-=movementFactor;
						}
					}
				}
				else
				{
					var tilex:uint = _tileCoords.x;
					var tiley:uint = _tileCoords.y;
					if (x < tilex + movementFactor && x > tilex - movementFactor || 
						y < tiley + movementFactor && y > tiley - movementFactor)
					{
						exists  = false;
						if (frame == Materials.WATER)
						{
							state.emitter.x = _tileCoords.x + 8;
							state.emitter.y = _tileCoords.y + 8;
							state.emitter.start();
						}
					}
					else
					{
						if (x < tilex) {
							x+=movementFactor;
						}
						if (x > tilex) {
							x-=movementFactor;
						}
						if (y < tiley) {
							y+=movementFactor;
						}
						if (y > tiley) {
							y-=movementFactor;
						}
					}
				}
			}
			super.update();
		}

        public function discard():void
        {
            _kind = Materials.NOTHING;
            exists = false;
        }

		public function set tileCoords(point:FlxPoint):void
		{
			_tileCoords.x = point.x * state.TILE_SIZE_X - state.TILE_SIZE_X/2;
			_tileCoords.y = point.y * state.TILE_SIZE_Y - state.TILE_SIZE_Y/2;
		}

		public function get kind():int
		{
			return _kind;
		}
		
		public function set kind(materialKind:int):void
		{
			trace("old: ", _kind, " new: ", materialKind);
			var pickingUp:Boolean = _kind == Materials.NOTHING &&
									materialKind != Materials.NOTHING;
			var dropping:Boolean = _kind != Materials.NOTHING &&
								   materialKind == Materials.NOTHING;
			if (pickingUp)
			{
				frame = materialKind;
				action = PICKUP;
				x = _tileCoords.x;
				y = _tileCoords.y;
				exists = true;
				inposition = false;
			}
			else if (dropping)
			{
				frame = _kind;
				action = DROP;
				x = state.player.x + OFFSET_X;
				y = state.player.y + OFFSET_Y;
				exists = true;
				inposition = false;
			}
			_kind = materialKind;
		}
	}
}
