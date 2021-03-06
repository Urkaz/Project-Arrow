package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import utils.Assets;
	
	public class Soldier extends Sprite 
	{
		private var imgSoldier:Image;
		public var armor:int;
		
		public function Soldier(x:Number, armorInit:int)
		{
			armor = armorInit;
			
			createSoldierArt();
			
			this.x = x - imgSoldier.width / 2;
			this.y = -imgSoldier.height+5;
		}
		
		private function createSoldierArt():void
		{
			imgSoldier = new Image(Assets.getAtlas("gameSprite").getTexture("soldado_" + armor));
			addChild(imgSoldier);
		}
		
		public function reduceArmor():void
		{
			armor -= 1;
			
			if (armor < 1)
				destroy();
			else
				imgSoldier.texture = Assets.getAtlas("gameSprite").getTexture("soldado_" + armor);
		}
		
		private function destroy():void
		{
			removeChild(imgSoldier);
		}
	}
}