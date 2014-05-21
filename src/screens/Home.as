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
			fondo_home = new Image(Assets.getTexture("PantallaInicial"));
			this.addChild(fondo_home)
			
			boton_playHome = new Button(Assets.getTexture("PlayInicialBtn"));
			this.addChild(boton_playHome)
			
			boton_playHome.x = stage.width / 2 - boton_playHome.width / 2;
			boton_playHome.y = 350;
			
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