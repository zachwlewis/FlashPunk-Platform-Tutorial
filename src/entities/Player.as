package entities
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	public class Player extends Entity
	{
		protected var playerImage:Image;
		protected const PLAYER_HSPEED:int = 80;
		protected const GRAVITY:int = 4;
		protected const JUMP:int = 150;
		protected var a:Point;
		protected var v:Point;
		
		
		public function Player()
		{
			playerImage = new Image(new BitmapData(16, 24));
			playerImage.color = 0xf0c826;
			graphic = playerImage;
			setHitbox(16,24);
			a = new Point();
			v = new Point();
		}
		
		public override function update():void
		{
			// Checking player input.
			var hInput:int = 0;
			if(Input.check(Key.LEFT)) hInput -= 1; // MOVE LEFT
			if(Input.check(Key.RIGHT)) hInput += 1; // MOVE RIGHT
			
			if(Input.pressed(Key.SPACE)) jump();
			
			// Update physics.
			v.x = PLAYER_HSPEED * hInput;
			
			a.y = GRAVITY;
			v.y += a.y;
			
			// Apply physics.
			x += v.x * FP.elapsed;
			y += v.y * FP.elapsed;
			
			// Simple collision with boundries.
			if(y + height > FP.screen.height)
			{
				v.y = 0;
				y = FP.screen.height - height;
			}
			
			// Update parent shit.
			super.update();
		}
		
		protected function jump():void
		{
			if(y + height >= FP.screen.height)
			{
				v.y = -JUMP;
			}
		}
	}
}