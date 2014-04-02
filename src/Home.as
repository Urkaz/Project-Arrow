package  
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author alvaro33bcp
	 */
	public class Home extends Sprite 
	{
		
		public function Home() 
		{
			super();
			this.hasEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Home")
			drawScreen();
		}
		
		private function drawScreen():void;
		{
			fondo_hierba = new Image(Assets.getTexture("FondoHierba");
			this.addChild(fondo_hierba);
		}
		
	}

}