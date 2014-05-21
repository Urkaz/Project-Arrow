package screens 
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
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
		
		private var soldierArray:Array = new Array();
		
		private var timerDelay:int = 1 * 1000;
		private var timerRepeat:int = 4;
		
		private var timer:Timer;
		
		private var scale:Number;
		
		private var levelType:String;
		private var victoryType:String;
		
		private var restanteInicio:TextField;
		
		
		
		private var unaPlataforma:Plataforma;
		
		
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
			
			imgMuralla = new Image(Assets.getAtlas("gameSprite").getTexture("Muralla_" + levelType));
			
			this.addChild(imgMuralla);
			
			//PLATAFORMAS
			for (var i:int = 0; i < datosNivel.Soldados.length; i++)
			{
				var platf:Plataforma = new Plataforma(datosNivel.Soldados[i][0], datosNivel.Soldados[i][1], datosNivel.Soldados[i][3], datosNivel.Soldados[i][2]);
				soldierArray.push(platf);
				trace("\t x:"+datosNivel.Soldados[i][0] + ", y:" + datosNivel.Soldados[i][1] + ", a:" + datosNivel.Soldados[i][2] + ", p:" + datosNivel.Soldados[i][3]);
				addChild(platf);
			}
			
			this.addChild(restanteInicio);
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
					
					var aux:Arrow = arrowArray[i];
					arrowArray[i] = arrowArray[arrowArray.length - 1];
					arrowArray[arrowArray.length - 1] = aux;
					
					trace("Flecha de tipo " + aux.Tipo + " destruida.");
					
					aux.destroy();
					
					this.removeChild(arrowArray.pop());
					--i;
					
					timer.addEventListener(TimerEvent.TIMER, spawnArrow);
				}
				else
				{
					arrowArray[i].y += arrowArray[i].Velocidad;
					
					//Si está fuera del escenario, borrar
					if (arrowArray[i].y > stage.stageHeight)
					{
						var aux:Arrow = arrowArray[i];
						arrowArray[i] = arrowArray[arrowArray.length - 1];
						arrowArray[arrowArray.length - 1] = aux;
						
						aux.destroy();
						
						this.removeChild(arrowArray.pop());
						--i;
					}
					else //Si no, se comprueban las colisiones
					{
						//PLATAFORMAS
						for each(var platf:Plataforma in soldierArray)
						{
							var puntaFlecha:Point = new Point(arrowArray[i].x + arrowArray[i].width / 2, arrowArray[i].y + arrowArray[i].height);
							var center:Point = new Point(platf.getSoldadoXGlobal + platf.soldado.width / 2, platf.getSoldadoYGlobal + platf.soldado.height / 2);
							var rad:Number = platf.soldado.width / 2;
							
							var dist:Number = Point.distance(center, puntaFlecha);
							
							if (dist < rad)
							{
								platf.soldado.reduceArmor();
								
								var aux:Arrow = arrowArray[i]
								arrowArray[i] = arrowArray[arrowArray.length - 1];
								arrowArray[arrowArray.length - 1] = aux;
								
								aux.destroy();
								
								this.removeChild(arrowArray.pop());
								--i;
								break;
							}
						}
					}
				}
			}
		}
	}
}