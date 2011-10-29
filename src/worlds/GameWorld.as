package worlds
{
	import entities.Player;
	
	import net.flashpunk.World;
	
	public class GameWorld extends World
	{
		public var playerEntity:Player;
		
		public function GameWorld()
		{
			super();
		}
		
		public override function begin():void
		{
			playerEntity = new Player();
			add(playerEntity);
		}
	}
}