package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Soldado extends Sprite 
	{
		private var imgSoldier:Image;
		private var armor:int;
		
		public function Soldado(x:Number, y:Number, armor:int)
		{
			this.x = x;
			this.y = y;
			this.armor = armor;
			
			//this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		/*private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				
			}
		}*/
		
		private function createSoldierArt():void
		{
			imgSoldier = new Image(Assets.getAtlas().getTexture("Soldier"));
			addChild(imgSoldier);
		}
		
		public function reduceArmor():void
		{
			armor -= 1;
			//Cambiar imagen por la de la nueva armadura
			
			if (armor < 1)
				destroy();
		}
		
		private function destroy():void
		{
			removeChild(imgSoldier);
		}
	}
}