package  
{
	import screens.Nivel;
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.events.Event;
	import screens.Home;
	import screens.LevelSelection;
	
	public class Game extends Sprite 
	{
		
		private var HomeScreen:Home;
		private var LevelsScreen:LevelSelection;
		private var GameScreen:Nivel;
		
		
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
			
			LevelsScreen = new LevelSelection();
			LevelsScreen.disposeTemporarily();
			this.addChild(LevelsScreen);
			
			GameScreen = new Nivel();
			GameScreen.disposeTemporarily();
			this.addChild(GameScreen);
			
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
					HomeScreen.disposeTemporarily();
					LevelsScreen.initialize();
					
					//screenWelcome.disposeTemporarily();
					//screenInGame.initialize();
					break;
				case "level":
					//Los params del evento CHANGE_SCREEN DE los niveles: {id: "level", lvl: x}
					LevelsScreen.disposeTemporarily();
					GameScreen.initialize();
					//trace("Nivel " + event.params.lvl);
					//Nivel.loadLevel(event.params.lvl);
					break;
					
			
			}

		}
	}

}