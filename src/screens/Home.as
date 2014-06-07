package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	import events.NavigationEvent;
	import utils.Textos;
	
	public class Home extends Sprite 
	{
		
		private var boton_playHome:Button;
		private var boton_borrarPartida:Button;
		private var boton_instrucciones:Button;
		
		private var fondo_home:Image;
		
		public function Home() 
		{
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
			
			boton_playHome = new Button(Assets.getAtlas("botones_"+Textos.LANG).getTexture("PlayInicial"));
			boton_borrarPartida = new Button(Assets.getAtlas("botones_"+Textos.LANG).getTexture("borrar"));
			boton_instrucciones = new Button(Assets.getAtlas("botones_"+Textos.LANG).getTexture("Instr"));
			
			boton_playHome.x = stage.stageWidth / 2 - boton_playHome.width / 2;
			boton_playHome.y = 350;
			
			boton_borrarPartida.x = stage.stageWidth / 2 + 5;
			boton_instrucciones.x = stage.stageWidth / 2 - boton_instrucciones.width - 5;
			boton_instrucciones.y = boton_borrarPartida.y = stage.stageHeight - boton_borrarPartida.height - 7;
			
			this.addChild(boton_playHome);
			this.addChild(boton_borrarPartida);
			this.addChild(boton_instrucciones);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == boton_playHome)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			else if((buttonClicked as Button) == boton_instrucciones)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "instruc"}, true));
			}
			else if ((buttonClicked as Button) == boton_borrarPartida)
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