package screens 
{
	import objects.Flecha;
	import starling.display.Image;
	//import starling.animation.Juggler;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.DatosNivel;
	import starling.animation.Tween;
	import starling.core.Starling;
	import utils.Assets;
	
	/**
	 * Esta clase será la que ponga en pantalla todos los elementos de los niveles (InGame)
	 */
	public class Nivel extends Sprite 
	{
		//var datosNivel:DatosNivel;
		private var itemsToAnimate:Vector.<Flecha>;
		private var gameState:String;
		private var playerSpeed:Number;
		private var elapsed:Number;
		private var fondo_home:Image;
		
		
		public function Nivel() 
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*
		public loadLevel(level:int):void
		{
			datosNivel = new DatosNivel(level);
		}
		*/
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			
			
			fondo_home = new Image(Assets.getTexture("FondoWelcome"));
			this.addChild(fondo_home)
			var scale:Number = stage.stageWidth / fondo_home.width;
			var flecha:Flecha = new Flecha(1, 1, true, 0);
			flecha.y = fondo_home.y - flecha.height;
			flecha.x = 500;
			this.addChild(flecha);
			var tween:Tween = new Tween(flecha, 10);
			//tween.animate("x", 0);
			tween.animate("y", 1920);
			Starling.juggler.add(tween);
			
			if(fondo_home.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_home.height;
			}
			
			//Escalado del fondo
			fondo_home.scaleX = fondo_home.scaleY = scale;
			
			//Escalado flecha
			flecha.scaleX = flecha.scaleY = scale;
			flecha.x *= scale;
			flecha.y *= scale;
			
			if (flecha.y > 1000) 
			{
				fondo_home.alpha = 0;
			}
			
			
			
		}
		
		
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
			
			//this.addEventListener(Event.ENTER_FRAME, checkElapsed);
			
			
			//Después de 3 segundos, empezar juego
			//empezar();
		}
		
		
	}

}