package screens 
{
	import starling.display.Sprite;
	import utils.DatosNivel;
	
	
	/**
	 * Esta clase será la que ponga en pantalla todos los elementos de los niveles (InGame)
	 */
	public class Nivel extends Sprite 
	{
		var datosNivel:DatosNivel;
		
		public function Nivel() 
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public loadLevel(level:int):void
		{
			datosNivel = new DatosNivel(level);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			
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
	}

}