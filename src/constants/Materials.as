package constants
{
	public class Materials
	{
		public static const NOTHING:int = -1;
		public static const GRASS:uint = 0;
		public static const DIRT:uint = 1;
		public static const WATER:uint = 2;
		public static const HOLE:uint = 3;
		public static const TREE:uint = 4;
		public static const ROCK:uint = 5;
		public static const WALL:uint = 6;
		
		// What you get when you pick up a material.
		public static function held(tileKind:uint):int
		{
			var lu:Array = [];
			lu[GRASS] = GRASS;
			lu[DIRT] = DIRT;
			lu[WATER] = WATER;
			lu[HOLE] = NOTHING;
			lu[TREE] = TREE;
			lu[ROCK] = ROCK
			lu[WALL] = ROCK;
			return lu[tileKind];
		}

		// What the tile you picked up becomes.
		public static function remains(tileKind:uint):int
		{
			var lu:Array = [];
			lu[GRASS] = DIRT;
			lu[DIRT] = HOLE;
			lu[WATER] = WATER;
			lu[HOLE] = NOTHING;
			lu[TREE] = GRASS;
			lu[ROCK] = GRASS;
			lu[WALL] = WALL;
			return lu[tileKind];
		}

		// What a held material becomes when it's dropped on different tiles.
		public static function dropped(held:uint, tileKind:uint):int
		{
			var lu:Array = [];
			lu[GRASS] = [];
			lu[GRASS][GRASS] = GRASS;
			lu[GRASS][DIRT] = GRASS;
			lu[GRASS][WATER] = WATER;
			lu[GRASS][TREE] = NOTHING;
			lu[GRASS][ROCK] = NOTHING;
			lu[GRASS][HOLE] = GRASS;
			lu[GRASS][WALL] = NOTHING;

			lu[DIRT] = [];
			lu[DIRT][GRASS] = DIRT;
			lu[DIRT][DIRT] = DIRT;
			lu[DIRT][WATER] = WATER;
			lu[DIRT][TREE] = NOTHING;
			lu[DIRT][ROCK] = NOTHING;
			lu[DIRT][HOLE] = DIRT;
			lu[DIRT][WALL] = NOTHING;

			lu[WATER] = [];
			lu[WATER][GRASS] = GRASS;
			lu[WATER][DIRT] = GRASS;
			lu[WATER][WATER] = WATER;
			lu[WATER][TREE] = TREE;
			lu[WATER][ROCK] = ROCK;
			lu[WATER][HOLE] = WATER;
			lu[WATER][WALL] = NOTHING;

			lu[TREE] = [];
			lu[TREE][GRASS] = TREE;
			lu[TREE][DIRT] = TREE;
			lu[TREE][WATER] = WATER;
			lu[TREE][TREE] = NOTHING;
			lu[TREE][ROCK] = NOTHING;
			lu[TREE][HOLE] = TREE;
			lu[TREE][WALL] = NOTHING;

			lu[ROCK] = [];
			lu[ROCK][GRASS] = ROCK;
			lu[ROCK][DIRT] = ROCK;
			lu[ROCK][WATER] = DIRT;
			lu[ROCK][TREE] = NOTHING;
			lu[ROCK][ROCK] = NOTHING;
			lu[ROCK][HOLE] = ROCK;
			lu[ROCK][WALL] = NOTHING;

			return lu[held][tileKind];
		}
	}
}
