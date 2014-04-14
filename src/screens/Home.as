package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	import events.NavigationEvent;
	
	public class Home extends Sprite 
	{
		
		private var boton_playHome:Button;
		private var titulo_home:Image;
		private var fondo_home:Image;
		
		
		
		public function Home() 
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
			fondo_home = new Image(Assets.getTexture("FondoWelcome"));
			this.addChild(fondo_home)
			
			boton_playHome = new Button(Assets.getTexture("BotonWelcome"));
			this.addChild(boton_playHome)
			
			titulo_home = new Image(Assets.getTexture("TituloWelcome"));
			this.addChild(titulo_home);
			
			
			//Poner las coordenadas de la resolución original, todos los escalados se harán luego
			titulo_home.x = 50;
			titulo_home.y = 200;
			
			boton_playHome.x = 250;
			boton_playHome.y = 1050;
			
			var scale:Number = stage.stageWidth / fondo_home.width;
			
			if(fondo_home.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_home.height;
			}
			//Escalado del fondo
			fondo_home.scaleX = fondo_home.scaleY = scale;
			
			//Escalado del título
			titulo_home.scaleX = titulo_home.scaleY = scale;
			titulo_home.x *= scale;
			titulo_home.y *= scale;
			
			//Escalado del botón
			boton_playHome.scaleX = boton_playHome.scaleY = scale;
			boton_playHome.x *= scale;
			boton_playHome.y *= scale;
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == boton_playHome)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
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