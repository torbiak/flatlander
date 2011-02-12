package
{
    import states.PlayState;
 
    import org.flixel.FlxGame;
 
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]
 
    public class Main extends FlxGame
    {
        /**
         * This is the main game constructor.
         */
        public function Main()
        {
            // Create Flixel Game.
            super(640, 480, PlayState, 2);
        }
    }
}