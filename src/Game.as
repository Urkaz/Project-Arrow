package  
{
	import objects.WindowPause;
	import screens.Instruct;
	import screens.GameLevel;
	import starling.animation.Tween;
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.events.Event;
	import screens.Home;
	import screens.LevelSelection;
	import utils.Texts;
	import utils.Assets;
	import utils.WindowBase;
	import objects.WindowFinal;
	import objects.WindowLevel;
	import flash.net.SharedObject;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Game extends Sprite 
	{
		
		private var HomeScreen:Home;
		private var LevelsScreen:LevelSelection;
		private var GameScreen:GameLevel;
		private var InstrucScreen:Instruct;
		private var ventana:WindowBase;
		private var sound_channel:SoundChannel;
		private var hunter:Sound;
		private var music_selection:Sound;
		private var music_level1:Sound;
		private var music_level2:Sound;
		
		public static var saveGame:SharedObject = SharedObject.getLocal("partida");
		
		public function Game() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		public function onAddedToStage(event:Event):void
		{
			trace("Juego inicializado!")
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
			this.addEventListener(events.NavigationEvent.POPUP_WINDOW, popUpWindow)
			
			//Idioma
			if (Game.saveGame.data["lang"] == undefined)
			{
				//Español por defecto la primera vez
				Game.saveGame.setProperty("lang", Texts.SPANISH);
				Texts.selectLang(Texts.SPANISH);
			}
			else if (Game.saveGame.data["lang"] == Texts.ENGLISH)
			{
				Texts.selectLang(Texts.ENGLISH);
			}
			else if (Game.saveGame.data["lang"] == Texts.SPANISH)
			{
				Texts.selectLang(Texts.SPANISH);
			}
			
			HomeScreen = new Home();
			this.addChild(HomeScreen);
			HomeScreen.initialize();
			
			hunter = new Assets.hunter() as Sound;
			sound_channel = hunter.play(0, 100);
			
			LevelsScreen = new LevelSelection();
			LevelsScreen.disposeTemporarily();
			this.addChild(LevelsScreen);
			
			InstrucScreen = new Instruct();
			InstrucScreen.disposeTemporarily();
			this.addChild(InstrucScreen);
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "play":
					//Ir al selector de niveles
					HomeScreen.disposeTemporarily();
					LevelsScreen.initialize();
					
					sound_channel.stop();
					music_selection = new Assets.music_selection() as Sound;
					sound_channel = music_selection.play(0, 100);
					break;
					
				case "level":
					//Los params del evento CHANGE_SCREEN DE los niveles: { id: "level", lvl: x, type: lvlType, vic: victoryType }
					this.removeChild(ventana);
					if(GameScreen != null) GameScreen.exitDestroy(); //Destruir si ya habia un nivel creado
					this.removeChild(GameScreen);
					
					LevelsScreen.disposeTemporarily();
					
					//Crear el nivel, no se tiene cargado ya como los demás
					GameScreen = new GameLevel(event.params.lvl, event.params.type, event.params.vic);
					this.addChild(GameScreen);
					GameScreen.initialize();
					
					sound_channel.stop();
					if (event.params.type == "normal") {
						music_level1 = new Assets.music_level1() as Sound;
						sound_channel = music_level1.play(0, 100);
					}
					if (event.params.type == "snow") {
						music_level2 = new Assets.music_level2() as Sound;
						sound_channel = music_level2.play(0, 100);
					}
					else { 
						music_level2 = new Assets.music_level2() as Sound;
						sound_channel = music_level2.play(0, 100);
					
					}
					break;
				case "menu": //Del nivel al selector de niveles
					GameScreen.exitDestroy();
					this.removeChild(GameScreen);
					GameScreen = null;
					
					LevelsScreen.initialize();
					
					sound_channel.stop();
					music_selection = new Assets.music_selection() as Sound;
					sound_channel = music_selection.play(0, 100);
					break;
				case "home": //Del selector de niveles al home
					LevelsScreen.disposeTemporarily();
					InstrucScreen.disposeTemporarily();
					HomeScreen.initialize();
					
					sound_channel.stop();
					hunter = new Assets.hunter() as Sound;
					sound_channel = hunter.play(0, 100);
					break;
				case "instruc": //Del home a las instrucciones
					HomeScreen.disposeTemporarily();
					InstrucScreen.initialize();
					
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
					ventana = new WindowLevel(event.params.lvl, event.params.stars, event.params.type, event.params.vic, stage);
					
					this.addChild(ventana);
					break;
					
				case "endlvl":
					this.removeChild(ventana);
					
					//Crear ventana
					ventana = new WindowFinal(event.params.lvl, event.params.stars, event.params.type, event.params.vic, stage, event.params.go);
					
					this.addChild(ventana);
					break;
					
				case "pause":
					this.removeChild(ventana);
					
					//Crear ventana
					ventana = new WindowPause(event.params.lvl, event.params.stars, event.params.type, event.params.vic, stage);
					
					this.addChild(ventana);
					break;
					
				case "close":
					if (event.params.cs)
					{
						this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: event.params.nav_ev}, true));
					}
					if (event.params.pause)
					{
						GameScreen.unPause();
					}
					removeChild(ventana);
					break;
			}
		}
	}
}