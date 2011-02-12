package sprites 
{	
	/**
	 * ...
	 * @author Akerboom
	 */
	public class GameAssets 
	{
		[Embed(source="../assets/grass.PNG")]
		public static var GrassSprite:Class;

		[Embed(source="../assets/stickMan.PNG")]
		public static var PlayerSprite:Class;
		
		public function GameAssets() 
		{
			
		}
		
	}

}