package	sprites
{
	import constants.GameStates;
	
	import org.flixel.*;
	
	import states.PlayState;

	public class HeldMaterial extends FlxSprite
	{
		public static const OFFSET_X:int = -2;
		public static const OFFSET_Y:int = -10;
		[Embed(source="../../assets/tiles.png")]
		public static var Tiles:Class;
		private var _kind:uint;
		public var state:PlayState;

		public function HeldMaterial(X:Number, Y:Number, materialKind:uint)
		{
			super(X, Y);
			_kind = materialKind;
			state = FlxG.state as PlayState;
			loadGraphic(Tiles, false, false, state.TILE_SIZE_X, state.TILE_SIZE_Y / 2);
			frame = _kind;
			exists = false;
		}

		override public function update():void
		{
			if (state.gameState == GameStates.PLAYING)
			{
				x = state.player.x + OFFSET_X;
				y = state.player.y + OFFSET_Y;
			}
			super.update();
		}

		public function get kind():uint
		{
			return _kind;
		}

		public function set kind(materialKind:uint):void
		{
			frame = materialKind;
			_kind = materialKind;
		}
	}
}
