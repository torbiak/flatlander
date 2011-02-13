package util 
{
	
	import Array;
	import Math;
	/**
	 * ...
	 * @author Akerboom
	 */
	public class LevelGenerator 
	{
		private static var levelSize:uint = 100;
		
		public function LevelGenerator() 
		{
			
		}
		
		public function createRandomArray(limit:uint):void
		{
			var array:Array = new Array();
			
			var high:uint = limit-1;//boundary wall and holes
			var low:uint = 0;
			
			var createGrass:Boolean = true;
			
			var i:uint;
			for (i = 0; i < levelSize; i++)
			{
				array[i] = new Array();
				var j:uint;
				for (j = 0; j < levelSize; j++)
				{
					if (i == 0 || i == levelSize-1 || j == 0 || j == levelSize-1)
					{
						//border
						array[i][j] = limit;
					}
					else
					{
						var ran:uint = getNextRandomNumber(low, high);
						while (ran == 3 || ran == 2)
						{
							//exclude holes and water
							ran = getNextRandomNumber(low, high);
						}
						if (ran == 5)
						{
							if (createGrass)
							{
								ran = 0;//grass
								createGrass = false;
							}
							else
							{
								createGrass = true;
							}
						}
						array[i][j] = ran;
					}
				}
			}
			
			var k:uint = 0;
			for (k = 0; k < 2; k++)
			{
				createPatch(array, 4);
			}
			for (k = 0; k < 3; k++)
			{
				createPatch(array, 5);
			}
			for (k = 0; k < 5; k++)
			{
				createPatch(array, 0);
			}
			for (k = 0; k < 1; k++)
			{
				createPatch(array, 1);
			}
		
			
			//create 5 rivers
			for (k = 0; k < 5; k++)
			{
				createRiver(array);
			}
				
			for (i = 0; i < levelSize; i++)
			{
				trace(array[i]);
			}
			
			function getNextRandomNumber(low:uint, high:uint ):uint
			{
				return Math.floor(Math.random() * (1 + high - low)) + low;
			}
			
			function createPatch(array:Array, type:uint):void
			{
				var start:uint = getNextRandomNumber(20, levelSize-20);
				var size:uint = getNextRandomNumber(10, 18);
				for (i = 0; i < size; i++)
				{
					var ran:uint = getNextRandomNumber(10, 18);
					for (j = 0; j < ran; j++)
					{
						array[start + i][start + j] = type;
					}
				}
			}
			
			function createRiver(array:Array):void
			{
				//create a river
				var start:uint = getNextRandomNumber(1, levelSize-2);
				for (i = 1; i < levelSize-1; i++)
				{
					ran = getNextRandomNumber(0, 1);
					array[i][start] = 2;//water
					if (ran == 0)
					{
						if (start > 1)
						{
							array[i][--start] = 2;//water
						}
					}
					else
					{
						if (start < levelSize-1)
						{
							array[i][start] = 2;//water
							array[i][++start] = 2;//water
						}
					}
				}
			}
		}

		
	}

}