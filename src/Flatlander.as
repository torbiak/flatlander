package
{
	import states.PlayState;
	
	import org.flixel.FlxGame;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class Flatlander extends FlxGame
	{
		/**
		 * This is the Flatlander game constructor.
		 */
		public function Flatlander()
		{
			// Create Flixel Game.
			super(320, 240, PlayState, 2);
		}
	}
}