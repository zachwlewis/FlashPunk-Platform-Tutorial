package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	import worlds.GameWorld;
	
	[SWF(width="512", height="448")]
	public class Main extends Engine
	{
		public function Main()
		{
			super(256, 224);
		}
		
		public override function init():void
		{
			trace("FlashPunk " + FP.VERSION + " started!");
			FP.screen.scale = 2;
			FP.world = new GameWorld();
		}
	}
}