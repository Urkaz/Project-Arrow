package screens 
{
	import starling.display.Image;
	import flash.utils.getTimer;
	import starling.display.Sprite;
	import utils.DatosNivel;
	import starling.events.Event;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * Esta clase será la que ponga en pantalla todos los elementos de los niveles (InGame)
	 */
	public class Nivel extends Sprite 
	{
		/*******************
		 * Atributos
		 *******************/
		private var datosNivel:DatosNivel;
		
		private var fondo_hierba:Image;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		
		/*******************
		 * Constructor
		 *******************/
		public function Nivel() 
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*******************
		 * Funciones
		 *******************/
		public function loadLevel(level:int):void
		{
			trace("Nivel " + level + " cargado");
			datosNivel = new DatosNivel(level);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			fondo_hierba = new Image(Assets.getTexture("MurallaHierba"));
			
			
			var scale:Number = stage.stageWidth / fondo_hierba.width;
			
			if(fondo_hierba.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_hierba.height;
			}
			
			//Escalado del fondo
			fondo_hierba.scaleX = fondo_hierba.scaleY = scale;
			
			
			this.addChild(fondo_hierba);
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
			
			this.addEventListener(Event.ENTER_FRAME, checkElapsed);
			
			//Después de 3 segundos, empezar juego
			empezar();
		}
		
		private function checkElapsed(e:Event):void 
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;
		}
		
		public function empezar():void 
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		//No se si esto nos servirá para lo que nosotros queremos
		private function onTouch(event:TouchEvent):void
		{
			touch = event.getTouch(stage);
			
			touchX = touch.globalX;
			touchY = touch.globalY;
		}
		
		private function onGameTick(e:Event):void 
		{
			//Toda la lógica aquí
		}
	}

}