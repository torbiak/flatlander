package states
{
    import sprites.GameAssets;
	
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
	import org.flixel.FlxGroup
 
    public class PlayState extends FlxState
    {	
		private const TILE_SIZE:int = 32;
		
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
			
        }
 
    }
}