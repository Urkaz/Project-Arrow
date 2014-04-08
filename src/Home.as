package  
{
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Home extends Sprite 
	{
		private var fondo_hierba:Image;
		private var boton_home:Button;
		private var titulo_home:Image;
		private var fondo_home:Image;
		
		
		
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
			//this.addChild(fondo_hierba);
			
			fondo_home = new Image(Assets.getTexture("FondoWelcome"));
			this.addChild(fondo_home)
			
			boton_home = new Button(Assets.getTexture("BotonWelcome"));
			this.addChild(boton_home)
			
			titulo_home = new Image(Assets.getTexture("TituloWelcome"));
			this.addChild(titulo_home);
			
			
			var scale:Number = stage.stageWidth / fondo_home.width;
			
			boton_home.x = 160;
			boton_home.y = 540;
			boton_home.scaleX = boton_home.scaleX / 2;
			boton_home.scaleY = boton_home.scaleY / 2;
			
			titulo_home.x = 50;
			titulo_home.y = 200;
			titulo_home.scaleX = titulo_home.scaleX / 2;
			titulo_home.scaleY = titulo_home.scaleY / 2;
			
			if(fondo_home.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_home.height;
			}   
			fondo_home.scaleX = fondo_home.scaleY = scale;
							
			
		}
		
	}

}