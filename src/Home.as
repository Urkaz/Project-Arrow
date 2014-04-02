package  
{
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Home extends Sprite 
	{
		private var fondo_hierba:Image;
		
		public function Home() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Home")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			fondo_hierba = new Image(Assets.getTexture("MurallaHierba"));
			this.addChild(fondo_hierba);
		}
		
	}

}