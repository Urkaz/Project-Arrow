package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import utils.Assets;
	
	public class Soldado extends Sprite 
	{
		private var imgSoldier:Image;
		private var armor:int;
		
		public function Soldado(x:Number, y:Number, armor:int)
		{
			createSoldierArt();
			
			this.x = x - imgSoldier.width / 2;
			this.y = y - imgSoldier.height /2;
			this.armor = armor;
		}
		
		private function createSoldierArt():void
		{
			imgSoldier = new Image(Assets.getTexture("Soldado_" + armor));
			addChild(imgSoldier);
		}
		
		public function reduceArmor():void
		{
			armor -= 1;
			imgSoldier.texture = Assets.getTexture("Soldado_" + armor);
			
			if (armor < 1)
				destroy();
		}
		
		private function destroy():void
		{
			removeChild(imgSoldier);
		}
	}
}