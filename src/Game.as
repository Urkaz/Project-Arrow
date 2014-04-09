package  
{
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.events.Event;
	import screens.Home;
	import screens.LevelSelection;
	
	public class Game extends Sprite 
	{
		
		private var HomeScreen:Home;
		private var LevelsScreen:LevelSelection;
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
			LevelsScreen = new LevelSelection();
			LevelsScreen.disposeTemporarily();
			
			this.addChild(LevelsScreen);
			
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
			}
		}
	}

}