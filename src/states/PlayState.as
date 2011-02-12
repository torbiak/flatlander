package states
{
	import sprites.Player;
	
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
 
    public class PlayState extends FlxState
    {	
		private const TILE_SIZE:int = 16;
		[Embed(source = '../../assets/map.txt', mimeType = "application/octet-stream")]
		private static var Map:Class;
		[Embed(source="../../assets/tiles.png")]
		public static var Tiles:Class;

		public var mapGroup:FlxGroup;
		public var playerGroup:FlxGroup;
		
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
			add(mapGroup);
			
			initPlayer();
			add(playerGroup);
        }
		
		public function initPlayer():void
    {	{
			//init the player group/layer
			playerGroup = new FlxGroup();
			
			//init the player
			var player:Player = new Player(20, 50);
			
			//add the player sprite to the player group/layer
			playerGroup.add(player);
    }	}
		
		private function initMap():void
		{
			//init the map group/layer
			mapGroup = new FlxGroup();
			
			//init the tile map
            var map:FlxTilemap = new FlxTilemap();
			map.drawIndex = 0;
			map.loadMap(new Map(), Tiles, TILE_SIZE, TILE_SIZE);
			
			//add the tile map to the tile group/layer
			mapGroup.add(map);
		}
 
    }
}