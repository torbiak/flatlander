package states
{
	import constants.*;
	
	import org.flixel.*;
	
	import sprites.*;
 
    public class PlayState extends FlxState
    {	
		public const TILE_SIZE_X:int = 16;
		public const TILE_SIZE_Y:int = 16;
		[Embed(source = '../../assets/100x100map.txt', mimeType = "application/octet-stream")]
		private static var Map:Class;
		[Embed(source="../../assets/tiles.png")]
		public static var Tiles:Class;
		[Embed(source = "../../assets/minimapTiles.png")]
		public static var MiniTiles:Class;
		[Embed(source="../../assets/particleSheet.png")]
		public static var Particles:Class;

		public var waterFlowCounter:Number = 0;
		public var map:FlxTilemap;
		public var miniMap:FlxTilemap;
		public var overlay:GrassOverlay;
		public var player:Player;
		public var gameState:uint;
		public var tileCoords:FlxPoint;
		public var tileCoordsFaced:FlxPoint;
		public var flowingWaterCoords:Array;
		public var emitter:FlxEmitter;
		
        /**
         * This is the main level of Frogger.
         */
        public function PlayState()
        {
            super();
			FlxG.framerate = 30;
        }
 
        /**
         * This is the main method responsible for creating all of the game pieces and layout out the level.
         */
        override public function create():void
        {
            initMap();
			initPlayer();
			initEmitter();
			
			add(miniMap);
			flowingWaterCoords = [];
			gameState = GameStates.PLAYING;
			FlxG.followBounds(0, 0, map.widthInTiles * TILE_SIZE_X, map.heightInTiles * TILE_SIZE_Y);
        }
		
		override public function update():void
		{
			waterFlowCounter += FlxG.elapsed;
			if (waterFlowCounter > 0.5){
				waterFlowCounter = 0;
				flowWater();
			}
			tileCoords = tileCoordsOfPlayer();
			tileCoordsFaced = tileCoordsPlayerIsFacing()


			FlxU.setWorldBounds(-(FlxG.scroll.x), -(FlxG.scroll.y), FlxG.width, FlxG.height);
			FlxU.collide(map, player);

			FlxG.follow(player);
			if (FlxG.keys.justPressed("B")) FlxG.showBounds = !FlxG.showBounds;
			if (FlxG.keys.justPressed("M")) miniMap.visible = !miniMap.visible;
			if (FlxG.keys.justPressed("W")) {
				emitter.x = player.x + 8;
				emitter.y = player.y + 8;
				emitter.start();
			}
			super.update();
		}

		public function initPlayer():void
		{
			player = new Player(20, 50);
			add(player);
   		}
		
		public function initMap():void
		{
            map = new FlxTilemap();
			map.collideIndex = 4;
			map.drawIndex = 0;
			map.loadMap(new Map(), Tiles, TILE_SIZE_X, TILE_SIZE_Y);
			add(map);
			overlay = new GrassOverlay(map);
			add(overlay.map);
			
			miniMap = new FlxTilemap();
			miniMap.drawIndex = 0;
			miniMap.loadMap(new Map(), MiniTiles, 1, 1);
			miniMap.visible = false;
			miniMap.scrollFactor.x = 0;
			miniMap.scrollFactor.y = 0;
			
		}
		
		public function initEmitter()
		{
			const splashVel = 70;
			
			emitter = new FlxEmitter();

			emitter.createSprites(Particles, 20);
			emitter.gravity = 0;
			emitter.delay = 0.2;
			emitter.maxParticleSpeed.x = splashVel;
			emitter.maxParticleSpeed.y = splashVel;
			emitter.minParticleSpeed.x = -splashVel;
			emitter.minParticleSpeed.y = -splashVel;
			//emitter.particleDrag = new FlxPoint(0, 0);
			
			add(emitter);
		}
		
		public function tileCoordsOfPlayer():FlxPoint
		{
			var pos:FlxPoint = new FlxPoint();
			pos.x = (player.x + player.frameWidth / 2) / TILE_SIZE_X;
			pos.y = (player.y + player.frameHeight / 2) / TILE_SIZE_Y;
			return pos;
		}
		
		public function tileCoordsPlayerIsFacing():FlxPoint
		{
			var pos:FlxPoint = tileCoordsOfPlayer();
			if (player.facing == FlxSprite.UP){
				pos.y -= 1;
			} else if (player.facing == FlxSprite.DOWN){
				pos.y += 1;
			} else if (player.facing == FlxSprite.RIGHT){
				pos.x += 1;
			} else if (player.facing == FlxSprite.LEFT){
				pos.x -= 1;
			}
			return pos;
		}

		public function isPlayerFacingWalkableTile():Boolean
		{
			return map.getTile(tileCoordsFaced.x, tileCoordsFaced.y) >= map.drawIndex;
		}

		public function setTileMaterial(pos:FlxPoint, material:int):void
		{
			map.setTile(pos.x, pos.y, material);
			overlay.updateTile(pos.x, pos.y);
			miniMap.setTile(pos.x, pos.y, material);
		}

		public function pickup():int
		{
			var pos:FlxPoint = tileCoordsFaced;
			var tileKind:uint = map.getTile(pos.x, pos.y);
			var remains:int = Materials.remains(tileKind);
			if (remains != Materials.NOTHING){
				setTileMaterial(pos, remains);
				registerFlowingWaterTile(pos);
			}
			return Materials.held(tileKind);
		}
		
		public function drop(held:int):int
		{
			var pos:FlxPoint = tileCoordsFaced;
			var tileKind:uint = map.getTile(pos.x, pos.y);
			var tileBecomes:int = Materials.dropped(held, tileKind);
			if (tileBecomes != Materials.NOTHING){
				setTileMaterial(pos, tileBecomes);
			}
			return tileBecomes;
		}

		private function registerFlowingWaterTile(pos:FlxPoint):void
		{
			trace("Checking for flow...");
			var tileKind:int = map.getTile(pos.x, pos.y)
			if (tileKind == Materials.WATER && adjacentTileOfMaterial(pos, Materials.HOLE)){
				flowingWaterCoords.push(pos);
				trace("Flowing water at: ", pos.x, " ", pos.y);
			} else if (tileKind == Materials.HOLE){
				var waterTile:FlxPoint = adjacentTileOfMaterial(pos, Materials.WATER);
				if (waterTile){
					flowingWaterCoords.push(waterTile);
				}
			}
		}

		private function adjacentTileOfMaterial(pos:FlxPoint, material:uint):FlxPoint
		{
			var offsets:Array = [-1, 1];
			for (var i:String in offsets){
				if (map.getTile(pos.x + offsets[i], pos.y) == material){
					return new FlxPoint(pos.x + offsets[i], pos.y);
				}
				if (map.getTile(pos.x, pos.y + offsets[i]) == material){
					return new FlxPoint(pos.x, pos.y + offsets[i]);
				}
			}
			return null;
		}


		private function flowWater():void
		{
			var pos:FlxPoint;
			var hole:FlxPoint;
			var newFlowCoords:Array = [];
			for (var i:String in flowingWaterCoords){
				pos = flowingWaterCoords[i];
				hole = adjacentTileOfMaterial(pos, Materials.HOLE);
				while (hole){
					setTileMaterial(hole, Materials.WATER);
					if (adjacentTileOfMaterial(hole, Materials.HOLE)){
						newFlowCoords.push(hole);
					}
					hole = adjacentTileOfMaterial(pos, Materials.HOLE);
				}
			}
			flowingWaterCoords = newFlowCoords;
		}

    }
}
