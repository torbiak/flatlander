package constants
{
	public class GameStates
	{
		public static const PLAYING:uint = 0; // Game is playing so animation is allowed
		public static const COLLISION:uint = 1; // A collision has occurred, stop all animation
		public static const RESTART:uint = 2; // Restart the game animations
		public static const GAME_OVER:uint = 3; // Game is over
		public static const DEATH_OVER:uint = 4; // A death animation is over
		public static const LEVEL_OVER:uint = 5; // A level is over
		
		public function GameStates()
		{
		}
	}
}