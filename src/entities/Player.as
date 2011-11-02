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
		protected var gravity:int = 4;
		protected const JUMP:int = 150;
		protected var a:Point;
		protected var v:Point;
		protected var bGravityFlipped:Boolean;
		
		
		public function Player()
		{
			playerImage = new Image(new BitmapData(16, 24));
			playerImage.color = 0xf0c826;
			graphic = playerImage;
			setHitbox(16,24);
			a = new Point();
			v = new Point();
			bGravityFlipped = false;
		}
		
		public override function update():void
		{
			// Checking player input.
			var hInput:int = 0;
			if(Input.check(Key.LEFT)) hInput -= 1; // MOVE LEFT
			if(Input.check(Key.RIGHT)) hInput += 1; // MOVE RIGHT
			
			if(Input.pressed(Key.SPACE)) jump();
			if(Input.pressed(Key.UP)) flipGravity();
			if(Input.pressed(Key.DOWN)) gravityToggle();
			
			// Update physics.
			v.x = PLAYER_HSPEED * hInput;
			
			if(bGravityFlipped)
			{
				a.y = -gravity;
			}
			else
			{
				a.y = gravity;
			}
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
			
			if(y < 0)
			{
				v.y = 0;
				y = 0;
			}
			
			// Update parent shit.
			super.update();
		}
		
		protected function jump():void
		{
			if(isOnGround)
			{
				if(bGravityFlipped)
				{
					v.y = JUMP;
				}
				else
				{
					v.y = -JUMP;
				}
			}
		}
		
		protected function flipGravity():void
		{
			if(isOnGround)
			{
				bGravityFlipped = !bGravityFlipped;
			}
		}
		
		protected function gravityToggle():void
		{
			if(gravity <= 4)
			{
				gravity = 6;
			}
			else if(gravity == 6)
			{
				gravity = 8;
			}
			else
			{
				gravity = 4;
			}
		}
		
		public function get isOnGround():Boolean
		{
			return (y + height >= FP.screen.height && !bGravityFlipped) || (y <= 0 && bGravityFlipped);
		}
	}
}