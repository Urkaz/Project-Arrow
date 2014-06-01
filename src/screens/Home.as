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
		private var boton_borrarPartida:Button;
		
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
			boton_borrarPartida = new Button(Assets.getTexture("Borrar"));
			
			boton_playHome.x = stage.stageWidth / 2 - boton_playHome.width / 2;
			boton_playHome.y = 350;
			
			boton_borrarPartida.height = 70;
			boton_borrarPartida.x = boton_playHome.x + 27;
			boton_borrarPartida.y = stage.stageHeight - boton_borrarPartida.height - 7;
			
			this.addChild(boton_playHome);
			this.addChild(boton_borrarPartida);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == boton_playHome)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			if ((buttonClicked as Button) == boton_borrarPartida)
			{
				Game.saveGame.clear();
				
				trace("2:>" + new Error().getStackTrace().match(/(?<=:)[0-9]*(?=])/g)[0], "Home: CAMBIAR NIVEL INICIAL AL QUE SE EMPEIZA LA PARTIDA AL NUM 1, EL 0 ES EL DE PRUEBA!!!!");
				if (Game.saveGame.data[0 + "_lock"] == undefined)
				{
					Game.saveGame.setProperty(0 + "_lock", false);
					Game.saveGame.setProperty(0 + "_stars", 0);
				}
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