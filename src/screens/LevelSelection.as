package screens 
{
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import flash.system.Capabilities;
	import utils.Assets;
	import events.NavigationEvent;
	import feathers.controls.ScreenNavigator;
	import feathers.events.CollectionEventType;
	import feathers.events.DragDropEvent;
	import feathers.events.ExclusiveTouch;
	
	/**
	 * ...
	 * @author alvaro33bcp
	 */
	public class LevelSelection extends Sprite 
	{
		private var fondo_niveles:Image;
		private var array_imagenes:Array;
		private var imagen_boton:Image;
		private var container:ScrollContainer;
		private var elboton:Button;
		
		
		public function LevelSelection() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Cargado menú principal")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			//fondo_hierba = new Image(Assets.getTexture("MurallaHierba"));
			//this.addChild(fondo_hierba);
			elboton = new Button(Assets.getTexture("BotonWelcome"));
			this.addChild(elboton);
			
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
			
			//fondo_niveles = new Image(Assets.getTexture("NivelesPrueba"));
			//this.addChild(fondo_niveles); BotonWelcome
			
			//var scale:Number = stage.stageWidth / fondo_niveles.width;
			
			//if(fondo_niveles.height * scale > stage.stageHeight){
				//scale = stage.stageHeight / fondo_niveles.height;
			//}
			//Escalado del fondo
			//fondo_niveles.scaleX = fondo_niveles.scaleY = scale;
			//this.addChild(container);
			
			//array_imagenes.push(fondo_niveles);
			/*
			//var xPosition:Number = 0;
			for (var i:int = 0; i < 12; i++)
			{
				var quad:Quad = new Quad(100, 100, 0xff0000);
				quad.x = xPosition;
				container.addChild(quad);
				xPosition += quad.width +10;
			}
			container.horizontalScrollPosition = container.maxHorizontalScrollPosition;
			
			
			container.scrollToPosition(10, 10, 3);
			
			createFoodItems();
			*/
		}
		
		
		/*
		private function createFoodItems():void
		{
			if (Math.random() > 0.95)
			{
				
				fondo_niveles.x = stage.stageHeight + 50;
				fondo_niveles.y = int(Math.random() * 5);
				this.addChild(fondo_niveles);
				
				//itemsToAnimate.push(fondo_niveles);
			}
		}
		*/
		
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == elboton)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "level"}, true));
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