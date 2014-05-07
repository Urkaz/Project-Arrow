package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import utils.Assets;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Plataforma extends Sprite 
	{
		private var anchoPlatMedio:int;
		private var imgPlatIzq:Image;
		private var imgPlatDer:Image;
		private var imgPlatMedio:Image;
		private var soldado:Soldado;
		
		public function Plataforma(x:Number, y:Number, ancho:int, soldierArmor:int) 
		{
			anchoPlatMedio = ancho;
			this.x = x;
			this.y = y;
			//this.soldierArmor = soldierArmor;
			createPlatformArt();
		}
		/*private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				
			}
		}*/
		private function createPlatformArt():void
		{
			imgPlatIzq = new Image(Assets.getTexture("Tablon_izq"));
			addChild(imgPlatIzq);
			
			imgPlatDer = new Image(Assets.getTexture("Tablon_der"));
			addChild(imgPlatDer);
			
			imgPlatMedio = new Image(Assets.getTexture("Tablon_medio"));
			addChild(imgPlatMedio);
			
			imgPlatMedio.width = anchoPlatMedio - imgPlatIzq.width * 2;
			imgPlatMedio.x = imgPlatIzq.width;
			imgPlatDer.x = (imgPlatMedio.x + imgPlatMedio.width) -2.6;
		}
	}
}