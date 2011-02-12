package
{
    import states.PlayState;
 
    import org.flixel.FlxGame;
 
    [SWF(width="480", height="800", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]
 
    public class Main extends FlxGame
    {
        /**
         * This is the main game constructor.
         */
        public function Main()
        {
            // Create Flixel Game.
            super(480, 800, PlayState, 1);
        }
    }
}