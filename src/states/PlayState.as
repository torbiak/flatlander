package states
{
	import constants.*;
	
	import org.flixel.*;
	
	import sprites.*;
 
    public class PlayState extends FlxState
    {	
		public const TILE_SIZE_X:int = 16;
		public const TILE_SIZE_Y:int = 16;
		[Embed(source = '../../assets/map.txt', mimeType = "application/octet-stream")]
		private static var Map:Class;
		[Embed(source="../../assets/tiles.png")]
		public static var Tiles:Class;

		public var map:FlxTilemap;
		public var player:Player;
		public var gameState:uint;
		public var tileCoords:FlxPoint;
		public var tileCoordsFaced:FlxPoint;
		
        /**
         * This is the main level of Frogger.
         */
        public function PlayState()
        {
            super();
        }
 
        /**
         * This is the main method responsible for creating all of the game pieces and layout out the level.
         */
        override public function create():void
        {
            initMap();
			initPlayer();
			
			gameState = GameStates.PLAYING;
        }
		
		override public function update():void
		{
			tileCoords = tileCoordsOfPlayer();
			tileCoordsFaced = tileCoordsPlayerIsFacing()


			FlxU.setWorldBounds(-(FlxG.scroll.x), -(FlxG.scroll.y), FlxG.width, FlxG.height);
			FlxU.collide(map, player);

			FlxG.follow(player);
			if (FlxG.keys.justPressed("B"))FlxG.showBounds = !FlxG.showBounds;
			super.update();	
		}

		public function initPlayer():void
		{
			player = new Player(20, 50);
			add(player);
			add(player.heldMaterial);
   		}
		
		public function initMap():void
		{
            map = new FlxTilemap();
			map.collideIndex = 4;
			map.drawIndex = 0;
			map.loadMap(new Map(), Tiles, TILE_SIZE_X, TILE_SIZE_Y);
			add(map);
		}
		
		public function tileCoordsOfPlayer():FlxPoint
		{
			var pos:FlxPoint = new FlxPoint();
			pos.x = (player.x + player.frameWidth / 2) / TILE_SIZE_X;
			pos.y = (player.y + player.frameHeight / 2) / TILE_SIZE_Y;
			return pos;
		}
		
		public function tileCoordsPlayerIsFacing():FlxPoint
		{
			var pos:FlxPoint = tileCoordsOfPlayer();
			if (player.facing == FlxSprite.UP){
				pos.y -= 1;
			} else if (player.facing == FlxSprite.DOWN){
				pos.y += 1;
			} else if (player.facing == FlxSprite.RIGHT){
				pos.x += 1;
			} else if (player.facing == FlxSprite.LEFT){
				pos.x -= 1;
			}
			return pos;
		}

		public function isPlayerFacingWalkableTile():Boolean
		{
			return map.getTile(tileCoordsFaced.x, tileCoordsFaced.y) >= map.drawIndex;
		}

		public function pickup():uint
		{
			var target:FlxPoint = tileCoordsPlayerIsFacing();
			var tileType:uint = map.getTile(target.x, target.y);
			map.setTile(target.x, target.y, 1);
			return tileType;
		}
		
		public function drop():void
		{
			
		}
 
    }
}
