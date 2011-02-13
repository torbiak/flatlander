package
{
    import org.flixel.*;
	import flash.display.*;
 
    public class Preloader extends FlxPreloader
    {
        public function Preloader()
        {
            className = "Flatlander";
            super();
			stage.quality = StageQuality.LOW;

        }
    }
}