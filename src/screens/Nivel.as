package screens 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import objects.Arrow;
	import objects.Plataforma;
	import objects.Soldado;
	import starling.display.Image;
	import flash.utils.getTimer;
	import starling.display.Sprite;
	import starling.text.TextField;
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
		
		private var imgMuralla:Image;
		
		private var arrowIndex:int;
		private var arrowArray:Array = new Array();
		
		private var timerDelay:int = 1 * 1000;
		private var timerRepeat:int = 4;
		
		private var timer:Timer;
		
		private var scale:Number;
		
		private var levelType:String;
		private var victoryType:String;
		
		private var seconds:int = 0;
		private var restanteInicio:TextField;
		private var unaPlataforma:Plataforma;
		private var soldado1:Soldado;
		
		
		/*******************
		 * Constructor
		 *******************/
		public function Nivel(level:int, type:String, victory:String) 
		{
			trace("Nivel " + level + " cargado, de tipo: " + type);
			datosNivel = new DatosNivel(level);
			
			levelType = type;
			victoryType = victory;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*******************
		 * Funciones
		 *******************/
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			restanteInicio = new TextField(300, 300, String(3), Assets.getFont("FontLevel").name, 100, 0xffffff);
			
			imgMuralla = new Image(Assets.getTexture("Muralla_" + levelType));
			
			scale = stage.stageWidth / imgMuralla.width;
			
			if(imgMuralla.height * scale > stage.stageHeight){
				scale = stage.stageHeight / imgMuralla.height;
			}
			
			//unaPlataforma = new Plataforma(10, 100, 350, 1);
			//soldado1 = new Soldado(50, 100, 1);
			
			//Escalado del fondo
			imgMuralla.scaleX = imgMuralla.scaleY = scale;
			
			this.addChild(imgMuralla);
			this.addChild(restanteInicio);
			//this.addChild(unaPlataforma);
			//this.addChild(soldado1);
			
			
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
		
		private function timerListener(e:TimerEvent):void
		{
			//Aquí falta por poner en pantalla los segundos restantes para que empieze el nivel
			//Al llegar a 0, el número estaría un segundo en pantalla hasta desaparecer (por eso el timer cuenta 4 segundos)
			
			if (timer.currentCount == 4)
			{
				this.removeChild(restanteInicio);
				timer.removeEventListener(TimerEvent.TIMER, timerListener);
				empezar();
			}
			else if (timer.currentCount == 3)
			{
				restanteInicio.text = "GO!";
			}
			else
			{
				restanteInicio.text = String(3 - timer.currentCount);
			}
		}
		
		private function empezar():void 
		{
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			timer.addEventListener(TimerEvent.TIMER, spawnArrow);
			
			timer.delay = Math.floor(Math.random() * (datosNivel.TimeSpawnMax - datosNivel.TimeSpawnMin + 1)) + datosNivel.TimeSpawnMin; // Random*(max-min+1)+min
			timer.reset();
			timer.start();
		}
		
		//Crea una nueva flecha
		//   Depende de la función nextArrowIndex
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
			timer.reset();
			timer.start();
		}
		
		//Calcula el índice de la príxima flecha, este índice determinará el tipo de flecha.
		private function nextArrowIndex():int
		{
			var prob:int = Math.floor(Math.random() * (100 - 0 + 1));
			
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