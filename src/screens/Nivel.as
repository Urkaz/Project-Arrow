package screens 
{
	import flash.geom.Point;
	import objects.Arrow;
	import objects.Plataforma;
	import objects.Soldado;
	import starling.display.Image;
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

		private var levelType:String;
		private var victoryType:String;
		private var restanteInicio:TextField;
		
		private var tiempoTrascurrido:int = 0;
		private var nextArrowDelay:Number;
		private var arrowTimer:Number = 0;
		
		
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
			
			this.addEventListener(Event.ENTER_FRAME, prepareGameTick);
		}
		
		private function prepareGameTick(e:Event):void 
		{
			tiempoTrascurrido += 1;
			
			//Al llegar a 0, el número estaría un segundo en pantalla hasta desaparecer (por eso el timer cuenta 4 segundos)
			if (int(tiempoTrascurrido / 60) == 4)
			{
				this.removeChild(restanteInicio);
				this.removeEventListener(Event.ENTER_FRAME, prepareGameTick);
				empezar();
			}
			else if (int(tiempoTrascurrido / 60) == 3)
			{
				restanteInicio.text = "GO!";
			}
			else
			{
				restanteInicio.text = String(3 - int(tiempoTrascurrido / 60));
			}
		}
		
		private function empezar():void 
		{
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			
			tiempoTrascurrido = 0;
			
			//Crear la primera flecha al empezar, sin esperas
			spawnArrow();
			
			//Calcular tiempo random de spawn de la siguiente flecha
			nextArrowDelay = Math.floor(Math.random() * (datosNivel.TimeSpawnMax*10 - datosNivel.TimeSpawnMin*10 + 1)) + datosNivel.TimeSpawnMin*10;
			nextArrowDelay /= 10
		}
		
		//Crea una nueva flecha
		//   Depende de la función nextArrowIndex
		private function spawnArrow():void 
		{	
			arrowIndex = nextArrowIndex();
			
			//trace("SPAWN FLECHA " + datosNivel.Flechas[0][arrowIndex]);
			var newArrow:Arrow = new Arrow(datosNivel.Flechas[0][arrowIndex], true, datosNivel.Flechas[2][arrowIndex]);
			
			this.addChild(newArrow);
			
			arrowArray.push(newArrow);
			
			//Recalcular tiempo para el spawn de la siguiente flecha
			//Calcular tiempo random de spawn de la siguiente flecha
			nextArrowDelay = Math.floor(Math.random() * (datosNivel.TimeSpawnMax*10 - datosNivel.TimeSpawnMin*10 + 1)) + datosNivel.TimeSpawnMin*10;
			nextArrowDelay /= 10
		}
		
		//Calcula el índice de la próxima flecha, este índice determinará el tipo de flecha.
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
			//Condiciones de victoria
			if (victoryType == "time")
			{
				if (int(tiempoTrascurrido / 60) == datosNivel.TiempoVictoria || soldierArray.length == 0)
				{
					this.removeEventListener(Event.ENTER_FRAME, onGameTick);
				}
			}
			
			//Toda la lógica aquí
			tiempoTrascurrido += 1;
			arrowTimer += 1;
			
			if (arrowTimer / 60 > nextArrowDelay)
			{
				spawnArrow();
				arrowTimer = 0;
			}
			
			//trace(int(tiempoTrascurrido / 60));
			
			//Mover flechas y comprobar sus estados (romper con el dedo, colisiones con plataformas, etc)
			for (var a:int = 0; a < arrowArray.length; ++a)
			{
				if (arrowArray[a].Status == Arrow.DESTROY)
				{
					trace("Flecha de tipo " + arrowArray[a].Tipo + " destruida.");
					a = deleteArrow(a);
					
				}
				else
				{
					arrowArray[a].y += arrowArray[a].Velocidad;
					
					//Si está fuera del escenario, borrar
					if (arrowArray[a].y > stage.stageHeight)
					{
						a = deleteArrow(a);
					}
					else //Si no, se comprueban las colisiones
					{
						//PLATAFORMAS
						for (var s:int = 0; s < soldierArray.length; ++s)
						{
							var puntaFlecha:Point = new Point(arrowArray[a].x + arrowArray[a].width / 2, arrowArray[a].y + arrowArray[a].height);
							var center:Point = new Point(soldierArray[s].SoldierGlobalX + soldierArray[s].SoldierWidth / 2, soldierArray[s].SoldierGlobalY + soldierArray[s].SoldierHeight / 2);
							var rad:Number = soldierArray[s].SoldierWidth / 2;
							
							var dist:Number = Point.distance(center, puntaFlecha);
							
							if (dist < rad)
							{
								//Si el soldado tiene armadura de nivel 3 (contra el fuego) no se le reducirá.
								if (!(soldierArray[s].SoldierArmor == 3 && arrowArray[a].Tipo == "fire"))
								{
									soldierArray[s].reduceSoldierArmor();
									
									if (soldierArray[s].SoldierArmor == 0)
										deleteSoldier(s);
								}
								
								deleteArrow(a);
								
								//Dejar de comprobar los soldados (se ha borrado la flecha al colisionar)
								break;
							}
						}
					}
				}
			}
		}
		
		private function deleteArrow(index:int):int
		{
			var aux:Arrow = arrowArray[index];
			arrowArray[index] = arrowArray[arrowArray.length - 1];
			arrowArray[arrowArray.length - 1] = aux;
			
			aux.destroy();
			
			this.removeChild(arrowArray.pop());
			
			return --index;
		}
		
		private function deleteSoldier(index:int):void
		{
			var aux:Plataforma = soldierArray[index];
			soldierArray[index] = soldierArray[soldierArray.length - 1];
			soldierArray[soldierArray.length - 1] = aux;
			
			soldierArray.pop();
		}
	}
}