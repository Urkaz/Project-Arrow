package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import utils.Assets;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Plataforma extends Sprite 
	{
		private var anchoPlatMedio:int;
		private var imgPlatIzq:Image;
		private var imgPlatDer:Image;
		private var imgPlatMedio:Image;
		public var soldado:Soldado;
		
		public function Plataforma(x:Number, y:Number, ancho:int, soldierArmor:int) 
		{
			anchoPlatMedio = ancho;
			this.x = x;
			this.y = y;
			
			soldado = new Soldado(anchoPlatMedio / 2, 0, soldierArmor);
			addChild(soldado);
			soldado.addEventListener(TouchEvent.TOUCH, onTouch);
			
			createPlatformArt();
		}
		
		public function get getSoldadoXGlobal():int
		{
			return x + soldado.x;
		}
		
		public function get getSoldadoYGlobal():int
		{
			return y + soldado.y;
		}
		
		
		
		private function onTouch(e:TouchEvent):void
		{
			var move:Touch = e.getTouch(this, TouchPhase.MOVED);
			if (move)
			{
				if (soldado.x > imgPlatMedio.x && soldado.x+soldado.width < imgPlatDer.x)
					soldado.x = move.globalX - (x + soldado.width / 2);
			}
		}
		
		private function createPlatformArt():void
		{
			imgPlatIzq = new Image(Assets.getTexture("Tablon_izq"));
			
			imgPlatDer = new Image(Assets.getTexture("Tablon_der"));
			
			imgPlatMedio = new Image(Assets.getTexture("Tablon_medio"));
			
			imgPlatMedio.width = anchoPlatMedio - imgPlatIzq.width * 2;
			imgPlatMedio.x = imgPlatIzq.width;
			imgPlatDer.x = imgPlatMedio.x + imgPlatMedio.width;
			
			addChild(imgPlatIzq);
			addChild(imgPlatMedio);
			addChild(imgPlatDer);
		}
	}
}