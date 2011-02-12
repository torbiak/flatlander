package sprites
{
    import org.flixel.*;
    
	public class Player extends FlxSprite
    {
		[Embed(source = "../../assets/stickMan.png")]
		private static var PlayerImage:Class;

        public function Player(X:Number = 0, Y:Number = 0):void
        {
        }
        public override function update():void
        {
            super.update();
        }
	}
}