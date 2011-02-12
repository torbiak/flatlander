package sprites 
{	
	/**
	 * ...
	 * @author Akerboom
	 */
	public class GameAssets 
	{
		[Embed(source="../../assets/tiles.png")]
		public static var TilesSprite:Class;

		[Embed(source="../../assets/stickMan.PNG")]
		public static var PlayerSprite:Class;
		
		public function GameAssets() 
		{
			
		}
		
	}

}