package screens 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import objects.Arrow;
	import starling.display.Image;
	import flash.utils.getTimer;
	import starling.display.Sprite;
	import utils.DatosNivel;
	import starling.events.Event;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * Esta clase será la que ponga en pantalla todos los elementos de los niveles (InGame)
	 */
	public class Nivel extends Sprite 
	{
		/*******************
		 * Atributos
		 *******************/
		private var datosNivel:DatosNivel;
		
		private var fondo_hierba:Image;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		private var tiempo:Number;
		
		private var arrowIndex:int;
		private var arrowArray:Array = new Array();
		
		private var timerDelay:int = 1 * 1000;
		private var timerRepeat:int = 1;
		
		private var timer:Timer;
		
		private var scale:Number;
		
		/*******************
		 * Constructor
		 *******************/
		public function Nivel() 
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*******************
		 * Funciones
		 *******************/
		public function loadLevel(level:int):void
		{
			trace("Nivel " + level + " cargado");
			datosNivel = new DatosNivel(level);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			fondo_hierba = new Image(Assets.getTexture("MurallaHierba"));
			
			scale = stage.stageWidth / fondo_hierba.width;
			
			if(fondo_hierba.height * scale > stage.stageHeight){
				scale = stage.stageHeight / fondo_hierba.height;
			}
			
			//Escalado del fondo
			fondo_hierba.scaleX = fondo_hierba.scaleY = scale;
			
			this.addChild(fondo_hierba);
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
			
			timer = new Timer(timerDelay, timerRepeat);
			timer.addEventListener(TimerEvent.TIMER, timerListener);
			timer.start();
		}
		
		private function timerListener (e:TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER, timerListener);
			empezar();
		}
		
		private function empezar():void 
		{
			//this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			timer.addEventListener(TimerEvent.TIMER, spawnArrow);
			
			timer.delay = Math.floor(Math.random() * (datosNivel.TimeSpawnMax - datosNivel.TimeSpawnMin + 1)) + datosNivel.TimeSpawnMin; // Random*(max-min+1)+min
			timer.reset();
			timer.start();
		}
		
		private function spawnArrow(e:TimerEvent):void 
		{
			arrowIndex = nextArrowIndex();
			
			//trace("SPAWN FLECHA " + datosNivel.Flechas[0][arrowIndex]);
			var newArrow:Arrow = new Arrow(datosNivel.Flechas[0][arrowIndex], true, datosNivel.Flechas[2][arrowIndex]);
			
			this.addChild(newArrow);
			
			//ESCALADO
			newArrow.scaleX = newArrow.scaleY = scale;
			newArrow.x *= scale;
			newArrow.y *= scale;
		
			arrowArray.push(newArrow);
			
			//Recalcular tiempo para el spawn de la siguiente flecha y reiniciar timer
			timer.delay = Math.floor(Math.random() * (datosNivel.TimeSpawnMax - datosNivel.TimeSpawnMin + 1)) + datosNivel.TimeSpawnMin; // Random*(max-min+1)+min
			//trace("\tSiguiente en: "+timer.delay+"ms");
			timer.reset();
			timer.start();
		}
		
		private function onTouch(event:TouchEvent):void
		{
			/* Lo dejo aquí por si acaso
			 * 
			 * var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
				trace("Touched object at position: " + localPos);
			}*/
		}
		
		private function nextArrowIndex():int
		{
			var prob:int = Math.floor(Math.random() * (100 - 0 + 1));
			
			//trace("\tProb:"  + prob + "%");
			
			var sum:int = 0;
			var typeIndex:int = 0;
			for (var i:int = 0; i < datosNivel.Flechas[1].length; ++i)
			{
				sum += int(datosNivel.Flechas[1][i]);
				if (prob < sum)
				{
					typeIndex = i;
					break;
				}
			}
			return typeIndex;
		}
		
		private function onGameTick(e:Event):void 
		{
			//Toda la lógica aquí
			for (var i:int = 0; i < arrowArray.length; ++i)
			{
				if (arrowArray[i].Status == Arrow.DESTROY)
				{
					timer.removeEventListener(TimerEvent.TIMER, spawnArrow);
					
					var aux:Arrow = arrowArray[i]
					arrowArray[i] = arrowArray[arrowArray.length - 1];
					arrowArray[arrowArray.length - 1] = aux;
					
					trace("Flecha de tipo " + aux.Tipo + " destruida.");
					
					this.removeChild(arrowArray.pop());
					--i;
					
					
					
					timer.addEventListener(TimerEvent.TIMER, spawnArrow);
				}
				else
				{
					arrowArray[i].y += arrowArray[i].Velocidad;
				}
			}
		}
	}

}