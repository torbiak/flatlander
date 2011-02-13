package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Erik
	 */
	public class GrassOverlay extends FlxObject
	{
		
		public var map:FlxTilemap;
		private var base:FlxTilemap;
		
		[Embed(source="../assets/grassOverlay.png")]
		public static var Tiles:Class;
		
		public const shouldOverlay:Object = {
				1 : 1,
				2 : 1,
				3 : 1
			};	
		
		public const TILE_SIZE_X:int = 8;
		public const TILE_SIZE_Y:int = 8;
		
		public function GrassOverlay(sourceMap:FlxTilemap) 
		{
			super();
			map = new FlxTilemap();
			map.auto = FlxTilemap.ALT;
			map.loadMap(genMapString(sourceMap), Tiles, TILE_SIZE_X, TILE_SIZE_Y);
			base = sourceMap;
		}
		
		public function updateTile(x:int, y:int):void
		{
			for (var j:int = y * 2; j < y * 2 + 2; j++) {
				for (var i:int = x * 2; i < x * 2 + 2; i++) {
					if (shouldOverlay[base.getTile(x, y)]) {
						map.setTile(i, j, 1);
					} else {
						map.setTile(i, j, 0);
					}
				}
			}
		}
		
		private function genMapString(sourceMap:FlxTilemap):String 
		{
			var w:int = sourceMap.widthInTiles;
			var h:int = sourceMap.heightInTiles;
			
			trace(w, h);
			var s:String = "";
			
			for (var j:int = 0; j < h; j++) {
				var l:Array = [];
				for (var i:int = 0; i < w; i++) {
					if (shouldOverlay[sourceMap.getTile(i,j)]) {
						l[i * 2] = 1;
						l[i * 2 + 1] = 1;
					} else {
						l[i * 2] = 0;
						l[i * 2 + 1] = 0;
					}
				}
				var lStr:String = l.join(',') + "\n";
				s = s.concat(lStr);
				s = s.concat(lStr);
			}
			return s;
		}
		
	}

}