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
	import objects.BotonNivel;
	
	public class LevelSelection extends Sprite 
	{
		private var container:ScrollContainer;
		private var layout:VerticalLayout;
		private var btnArray:Array = new Array();
		private var atrasBtn:Button;
		
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
			//Leer lista de niveles
			var levelList:XML = new XML(new Assets.levelList());
			var attr:XMLList;
			
			//SCROLL
			container = new ScrollContainer();
			container.hasElasticEdges = false;
			
			//Desbloquear primer nivel
			trace("Clase LevelSelection:", "CAMBIAR NIVEL INICIAL AL QUE SE EMPEIZA LA PARTIDA AL NUM 1, EL 0 ES EL DE PRUEBA!!!!");
			Game.saveGame.setProperty(0 + "_lock", false);
			
			attr = levelList.level.attributes();
			for (var s:int = 0; s < attr.length(); s = s+3)
			{
				var boton:BotonNivel;
				
				//Leer partida guardada y poner puntuacion, estrellas y lock
				var stars:int = int(Game.saveGame.data[attr[s] + "_stars"]);
				
				boton = new BotonNivel(attr[s + 1], attr[s + 2], attr[s], stars);
				if(!(Game.saveGame.data[attr[s] + "_lock"] == undefined || Game.saveGame.data[attr[s] + "_lock"]))
					boton.Unlock();
				
				container.addChild(boton);
				btnArray.push(boton);
			}
			
			//container.scrollToPosition(0,1000);
			container.padding = 0;
			container.width = stage.stageWidth;
			container.height = stage.stageHeight - 40;
			
			layout = new VerticalLayout();
			container.layout = layout;
			
			//Boton para volver al home
			atrasBtn = new Button(Assets.getTexture("PlayInicialBtn"));
			atrasBtn.height = 40;
			atrasBtn.width = stage.stageWidth;
			atrasBtn.x = stage.stageWidth / 2 - atrasBtn.width / 2;
			atrasBtn.y = stage.stageHeight - atrasBtn.height;
			
			this.addChild(container);
			this.addChild(atrasBtn);
			
			this.addEventListener(Event.TRIGGERED, buttonClick);
		}
		
		private function buttonClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == atrasBtn)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "home"}, true));
			}
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function initialize():void
		{
			//No desbloquear el nivel 2 (no está disponible y logicamente da error)
			Game.saveGame.setProperty(2 + "_lock", true);
			
			this.visible = true;
			
			//Actualizar o desbloquear bontones niveles
			for (var i:int = 0; i < container.numChildren; ++i) 
			{
				if (!(Game.saveGame.data[i + "_lock"] == undefined || Game.saveGame.data[i + "_lock"]))
				{
					btnArray[i].Unlock();
					btnArray[i].Update(int(Game.saveGame.data[i + "_stars"]));
					//trace(i+1, Game.saveGame.data[i + "_stars"]);
				}
				else
					btnArray[i].Lock();
			}
		}
	}
}