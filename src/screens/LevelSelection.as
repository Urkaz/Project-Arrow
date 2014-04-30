package screens 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	import events.NavigationEvent;
	import feathers.controls.ScrollScreen;
	import feathers.events.FeathersEventType;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.controls.ScrollBar;
	import feathers.controls.Scroller;
	
	public class LevelSelection extends Sprite 
	{
		private var fondo_niveles:Image;
		private var boton_LevelPrueba:Button;
		
		public function LevelSelection() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Cargado selector de niveles")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			boton_LevelPrueba = new Button(Assets.getTexture("BotonWelcome"));
			
			fondo_niveles = new Image(Assets.getTexture("NivelesPrueba"));
			
			var scale:Number = stage.stageWidth / fondo_niveles.width;
			
			if(fondo_niveles.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_niveles.height;
			}
			
			//Escalado del fondo
			fondo_niveles.scaleX = fondo_niveles.scaleY = scale;
			
			this.addChild(fondo_niveles);
			
			
			this.addEventListener(Event.TRIGGERED, onLevelClick);
			
			
			//SCROLL
			var container:ScrollContainer = new ScrollContainer();
			this.addChild(container);
			
			var yPosition:Number = 0;
			for(var i:int = 0; i < 60; i++)
			{
				var quad:Image = new Image(Assets.getTexture("candado750"));
				quad.y = yPosition;
				quad.height = stage.stageHeight/7;
				quad.width = stage.stageWidth;
				
				container.addChild( quad );
				trace(quad.height);
				trace(quad.width);
				
				yPosition += quad.width + 10;
 			}
			
			
			container.padding = 0;
			container.width = stage.stageWidth;
			container.height = stage.stageHeight;
 			
			//.gap es la separaciÃ³n.
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 0;
			container.layout = layout;
			
			this.addChild(boton_LevelPrueba);
		}
		
		private function onLevelClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == boton_LevelPrueba)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "level", lvl: 0}, true));
			}
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