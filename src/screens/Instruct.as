package screens 
{
	import events.NavigationEvent;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.events.Event;
	import utils.Assets;
	import utils.Texts;
	
	public class Instruct extends Sprite 
	{	
		private var instr:MovieClip;
		private var atr:Button;
		private var adl:Button;
		private var salir:Button;
		private var index:int = 0;
		
		public function Instruct() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			trace("Cargadas instrucciones")
			drawScreen();
		}
		
		private function drawScreen():void 
		{
			instr = new MovieClip(Assets.getAtlas("reglas_"+Texts.LANG).getTextures("instr_"), 1);
			instr.loop = false;
			
			atr = new Button(Assets.getAtlas("reglas_"+Texts.LANG).getTexture("Flecha_Izquierda"));
			adl = new Button(Assets.getAtlas("reglas_"+Texts.LANG).getTexture("Flecha_Derecha"));
			salir = new Button(Assets.getAtlas("reglas_"+Texts.LANG).getTexture("Boton_Salir"));
			
			atr.y = adl.y = stage.stageHeight - atr.height;
			atr.x = stage.x;
			adl.x = stage.stageWidth - adl.width;
			
			salir.x = stage.stageWidth / 2 - salir.width / 2;
			salir.y = stage.stageHeight - salir.height;
			
			instr.stop();
			
			instr.currentFrame = index;
			
			Starling.juggler.add(instr);
			
			this.addChild(instr);
			this.addChild(adl);
			this.addChild(salir);
			
			this.addEventListener(Event.TRIGGERED, onClick);
		}
		
		private function onClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == adl)
			{
				++index;
				if (index > 0)
				{
					instr.currentFrame = index;
					this.addChild(atr);
				}
				if (index == instr.numFrames - 1)
				{
					instr.currentFrame = index;
					this.removeChild(adl);
				}
			}
			else if((buttonClicked as Button) == atr)
			{
				--index;
				if (index == 0)
				{
					instr.currentFrame = index;
					this.removeChild(atr);
				}
				if (index < instr.numFrames - 1)
				{
					instr.currentFrame = index;
					this.addChild(adl);
				}
			}
			else if ((buttonClicked as Button) == salir)
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
			this.visible = true;
		}
	}
}