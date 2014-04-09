package screens 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	import events.NavigationEvent;
	
	/**
	 * ...
	 * @author alvaro33bcp
	 */
	public class LevelSelection extends Sprite 
	{
		private var fondo_niveles:Image;
		
		public function LevelSelection() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Cargado menú principal")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			//fondo_hierba = new Image(Assets.getTexture("MurallaHierba"));
			//this.addChild(fondo_hierba);
			
			
			
			fondo_niveles = new Image(Assets.getTexture("NivelesPrueba"));
			this.addChild(fondo_niveles);
			
			var scale:Number = stage.stageWidth / fondo_niveles.width;
			
			if(fondo_niveles.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_niveles.height;
			}
			//Escalado del fondo
			fondo_niveles.scaleX = fondo_niveles.scaleY = scale;
			
			
			
			
			
			
			
			
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
		
	}

}