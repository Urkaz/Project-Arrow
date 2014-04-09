package  
{
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.events.Event;
	import screens.Home;
	
	public class Game extends Sprite 
	{
		
		private var HomeScreen:Home;
		//private var LevelsScreen:Levels;
		//private var GameScreen:InGame;
		
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			
		}
		
		public function onAddedToStage(event:Event):void
		{
			trace("Juego inicializado!")
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
			
			//screenZone = new ZoneSelector();
			//screenZone.disposeTemporarily();
			//this.addChild(screenZone);
			
			HomeScreen = new Home();
			this.addChild(HomeScreen);
			HomeScreen.initialize();
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "play":
					trace("Pulsado botón PLAY");
					//Ir a la seleccion de ZONAS
					//screenWelcome.disposeTemporarily();
					//screenInGame.initialize();
					break;
				case "level":
					//Los params del evento CHANGE_SCREEN DE los niveles: {id: "level", lvl: x}
					
					trace("Nivel " + event.params.lvl);
					//Nivel.loadLevel(event.params.lvl);
					break;
			}

		}
	}

}