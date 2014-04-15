package screens 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	import events.NavigationEvent;
	
	public class LevelSelection extends Sprite 
	{
		private var fondo_niveles:Image;
		private var boton_LevelPrueba:Button;
		
		public function LevelSelection() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Cargado selector de niveles")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			boton_LevelPrueba = new Button(Assets.getTexture("BotonWelcome"));
			
			fondo_niveles = new Image(Assets.getTexture("NivelesPrueba"));
			
			var scale:Number = stage.stageWidth / fondo_niveles.width;
			
			if(fondo_niveles.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_niveles.height;
			}
			
			//Escalado del fondo
			fondo_niveles.scaleX = fondo_niveles.scaleY = scale;
			
			this.addChild(fondo_niveles);
			this.addChild(boton_LevelPrueba);
			
			this.addEventListener(Event.TRIGGERED, onLevelClick);
		}
		
		private function onLevelClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == boton_LevelPrueba)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "level", lvl: 0}, true));
			}
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