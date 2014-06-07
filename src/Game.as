package  
{
	import objects.VentanaPausa;
	import screens.Nivel;
	import starling.animation.Tween;
	import starling.display.Sprite;
	import events.NavigationEvent;
	import starling.events.Event;
	import screens.Home;
	import screens.LevelSelection;
	import utils.Textos;
	import utils.Assets;
	import utils.VentanaBase;
	import objects.VentanaFinal;
	import objects.VentanaNiveles;
	import flash.net.SharedObject;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Game extends Sprite 
	{
		
		private var HomeScreen:Home;
		private var LevelsScreen:LevelSelection;
		private var GameScreen:Nivel;
		private var ventana:VentanaBase;
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
			
			HomeScreen = new Home();
			this.addChild(HomeScreen);
			HomeScreen.initialize();
			
			hunter = new Assets.hunter() as Sound;
			sound_channel = hunter.play(0, 100);
			
			LevelsScreen = new LevelSelection();
			LevelsScreen.disposeTemporarily();
			this.addChild(LevelsScreen);
			
			Textos.selectLang("es");
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
					GameScreen = new Nivel(event.params.lvl, event.params.type, event.params.vic);
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
					HomeScreen.initialize();
					
					sound_channel.stop();
					hunter = new Assets.hunter() as Sound;
					sound_channel = hunter.play(0, 100);
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
					
				case "pause":
					this.removeChild(ventana);
					
					//Crear ventana
					ventana = new VentanaPausa(event.params.lvl, event.params.stars, event.params.type, event.params.vic, stage);
					
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