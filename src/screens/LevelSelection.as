package screens 
{
	import adobe.utils.CustomActions;
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
	import utils.BotonNivel;
	
	public class LevelSelection extends Sprite 
	{
		private var fondo_niveles:Image;
		private var container:ScrollContainer;
		private var layout:VerticalLayout;
		
		
		public function LevelSelection() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Cargado selector de niveles")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			fondo_niveles = new Image(Assets.getTexture("NivelesPrueba"));
			
			var scale:Number = stage.stageWidth / fondo_niveles.width;
			
			if(fondo_niveles.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_niveles.height;
			}
			
			//Escalado del fondo
			fondo_niveles.scaleX = fondo_niveles.scaleY = scale;
			
			this.addChild(fondo_niveles);
			
			
			//Leer lista de niveles
			var levelList:XML = new XML(new Assets.levelList());
			var attr:XMLList;
			
			//SCROLL
			container = new ScrollContainer();
			this.addChild(container);
			
			attr = levelList.level.attributes();
			for (var s:int = 0; s < attr.length(); s = s+3)
			{
				var boton:BotonNivel;
				
				
				//Leer partida guardada y poner puntuacion, estrellas y lock
				boton = new BotonNivel(attr[s+1], attr[s+2], attr[s], 0, 3, false);
				container.addChild(boton);
			}
			
			//container.scrollToPosition(0,1000);
			container.padding = 0;
			container.width = stage.stageWidth;
			container.height = stage.stageHeight;
 			
			//Gap es la separación.
			layout = new VerticalLayout();
			//layout.gap = 0;
			container.layout = layout;
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