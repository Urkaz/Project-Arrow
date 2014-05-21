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
		
		public function Soldado(x:Number, y:Number, armorInit:int)
		{
			armor = armorInit;
			
			createSoldierArt();
			
			this.x = x - imgSoldier.width / 2;
			this.y = y - imgSoldier.height / 2;
		}
		
		private function createSoldierArt():void
		{
			imgSoldier = new Image(Assets.getTexture("Soldado_" + armor));
			addChild(imgSoldier);
		}
		
		public function reduceArmor():void
		{
			armor -= 1;
			
			if (armor < 1)
				destroy();
			else
				imgSoldier.texture = Assets.getTexture("Soldado_" + armor);
		}
		
		private function destroy():void
		{
			removeChild(imgSoldier);
		}
	}
}