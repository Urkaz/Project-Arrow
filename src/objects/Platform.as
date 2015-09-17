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
	
	public class Platform extends Sprite 
	{
		private var anchoPlatMedio:int;
		private var imgPlatIzq:Image;
		private var imgPlatDer:Image;
		private var imgPlatMedio:Image;
		private var soldado:Soldier;
		
		public function Platform(x:Number, y:Number, ancho:int, soldierArmor:int) 
		{
			anchoPlatMedio = ancho;
			this.x = x;
			this.y = y;
			
			soldado = new Soldier(anchoPlatMedio / 2, soldierArmor);
			addChild(soldado);
			soldado.addEventListener(TouchEvent.TOUCH, onTouch);
			
			createPlatformArt();
		}
		
		//HELPERS/GETTERS/SETTERS
		public function reduceSoldierArmor():void
		{
			soldado.reduceArmor();
		}
		
		public function get SoldierGlobalX():int
		{
			return x + soldado.x;
		}
		
		public function get SoldierGlobalY():int
		{
			return y + soldado.y;
		}
		
		public function get SoldierHeight():int
		{
			return soldado.height;
		}
		
		public function get SoldierWidth():int
		{
			return soldado.width;
		}
		
		public function get SoldierArmor():int
		{
			return soldado.armor;
		}
		
		//FUNCIONES
		private function onTouch(e:TouchEvent):void
		{
			var move:Touch = e.getTouch(this, TouchPhase.MOVED);
			var num:int = 0;
			if (move)
			{
				num = move.globalX - move.previousGlobalX;
				
				if (soldado.x + num >= imgPlatMedio.x && soldado.x + soldado.width + num <= imgPlatDer.x)
					soldado.x += num;
				else
					if (num < 0 && soldado.x + num < imgPlatMedio.x)
						soldado.x = imgPlatMedio.x;
					else if (num > 0 && soldado.x + soldado.width + num > imgPlatDer.x)
						soldado.x = imgPlatDer.x - soldado.width;
			}
		}
		
		private function createPlatformArt():void
		{
			imgPlatIzq = new Image(Assets.getAtlas("gameSprite").getTexture("platf_izq"));
			
			imgPlatDer = new Image(Assets.getAtlas("gameSprite").getTexture("platf_der"));
			
			imgPlatMedio = new Image(Assets.getAtlas("gameSprite").getTexture("platf_med"));
			
			imgPlatMedio.width = anchoPlatMedio - imgPlatIzq.width * 2;
			imgPlatMedio.x = imgPlatIzq.width-1.5;
			imgPlatDer.x = imgPlatMedio.x + imgPlatMedio.width-1.5;
			
			addChild(imgPlatIzq);
			addChild(imgPlatMedio);
			addChild(imgPlatDer);
			
			this.swapChildren(soldado, imgPlatIzq);
			this.swapChildren(soldado, imgPlatMedio);
			this.swapChildren(soldado, imgPlatDer);
		}
	}
}