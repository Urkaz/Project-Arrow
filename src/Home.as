package  
{
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	
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
			var ancho:int = stage.stageWidth;
			var alto:int = stage.stageHeight;

			fondo_hierba = new Image(Assets.getTexture("MurallaHierba"));
			fondo_hierba.scaleX = ancho / fondo_hierba.width;
			fondo_hierba.scaleY = alto / fondo_hierba.height;
			
			this.addChild(fondo_hierba);
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