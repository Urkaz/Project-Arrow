package  
{
	import screens.Nivel;
	import starling.animation.Tween;
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.events.Event;
	import screens.Home;
	import screens.LevelSelection;
	import utils.Ventana;
	import utils.VentanaFinal;
	import utils.VentanaNiveles;
	import flash.net.SharedObject;
	
	public class Game extends Sprite 
	{
		
		private var HomeScreen:Home;
		private var LevelsScreen:LevelSelection;
		private var GameScreen:Nivel;
		private var ventana:Ventana;
		
		public static var saveGame:SharedObject = SharedObject.getLocal("partida");
		
		public function Game() 
		{
			saveGame.clear();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			
		}
		
		public function onAddedToStage(event:Event):void
		{
			trace("Juego inicializado!")
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
			this.addEventListener(events.NavigationEvent.POPUP_WINDOW, popUpWindow)
			
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
					//Ir al selector de niveles
					HomeScreen.disposeTemporarily();
					LevelsScreen.initialize();
					break;
					
				case "level":
					//Los params del evento CHANGE_SCREEN DE los niveles: { id: "level", lvl: x, type: lvlType, vic: victoryType }
					this.removeChild(ventana);
					this.removeChild(GameScreen);
					
					LevelsScreen.disposeTemporarily();
					
					//Crear el nivel, no se tiene cargado ya como los demás
					GameScreen = new Nivel(event.params.lvl, event.params.type, event.params.vic);
					this.addChild(GameScreen);
					GameScreen.initialize();
					break;
				case "menu":
					this.removeChild(GameScreen);
					
					GameScreen = null;
					
					LevelsScreen.initialize();
					
					break;
			}
		}
		
		private function popUpWindow(event:NavigationEvent):void 
		{
			switch (event.params.id)
			{
				case "lvlstats":
					this.removeChild(ventana);
					
					//Crear ventana
					ventana = new VentanaNiveles(event.params.lvl, event.params.stars, event.params.type, event.params.vic, stage);
					
					this.addChild(ventana);
					break;
					
				case "endlvl":
					this.removeChild(ventana);
					
					//Crear ventana
					ventana = new VentanaFinal(event.params.lvl, event.params.stars, event.params.type, event.params.vic, stage, event.params.go);
					
					this.addChild(ventana);
					break;
					
				case "close":
					if (event.params.cs)
					{
						this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: event.params.nav_ev}, true));
					}
					removeChild(ventana);
					break;
			}
		}
	}
}