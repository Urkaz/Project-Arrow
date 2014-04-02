package  
{
	import starling.display.Sprite;
	import events.NavigationEvent;
	import screens.Home; 
	import starling.events.Event;
	
	/**
	 * ...
	 * @author alvaro33bcp
	 */
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
			trace("inicializado!")
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)

			HomeScreen = new Home();
			HomeScreen.disposeTemporarily();
			this.addChild(HomeScreen);
		}
		
		
	}

}