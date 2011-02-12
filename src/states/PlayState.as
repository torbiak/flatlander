package states
{
    import sprites.GameAssets;
	
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
 
    public class PlayState extends FlxState
    {	
		private const TILE_SIZE:int = 16;
		[Embed(source = '../../assets/map.txt', mimeType = "application/octet-stream")] private var Map:Class;
		
		public var mapGroup:FlxGroup;
		
        /**
         * This is the main level of Frogger.
         */
        public function PlayState()
        {
            super();
			mapGroup = new FlxGroup();
        }
 
        /**
         * This is the main method responsible for creating all of the game pieces and layout out the level.
         */
        override public function create():void
        {
			// Create the BG sprite
            initMap();
			add(mapGroup);
        }
		
		private function initMap():void
		{
			// Create the BG sprite
            var map:FlxTilemap = new FlxTilemap();
			map.drawIndex = 0;
			map.loadMap(new Map(), GameAssets.TilesSprite, TILE_SIZE, TILE_SIZE);
			mapGroup.add(map);
		}
 
    }
}