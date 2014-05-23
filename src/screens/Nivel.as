package screens 
{
	import events.NavigationEvent;
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
	
	/*
	 * Tiempo
	 * 1- pasarse el nivel
	 * 2- puntuacion
	 * 3- perfecto (vidas)
	 * 
	 * Vida
	 * 1- Pasarte el nivel
	 * 2- Puntuación
	 * 3- Tiempo min (x segundos)
	 * 
	 * Combos
	 * 1- pasarlo
	 * 2- sin morir
	 * 3- tiempo
	 * 
	
	
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
		private var barraImg:Image;
		private var relojImg:Image;
		private var vidasImg:Image;
		
		private var arrowIndex:int;
		private var arrowArray:Array = new Array();
		private var soldierArray:Array = new Array();
		
		private var levelNumber:int;
		private var levelType:String;
		private var victoryType:String;
		private var restanteInicioTxt:TextField;
		
		private var tiempoTrascurrido:int = 0;
		private var nextArrowDelay:Number;
		private var arrowTimer:Number = 0;
		
		private var tiempoTxt:TextField;
		private var min:int
		private var sec:int
		
		private var numVidas:int;
		private var vidasTxt:TextField;
		
		private var numPuntos:int = 0;
		private var puntosTxt:TextField;
		
		private var combo:Array = new Array(Arrow.TYPE_NO_TYPE,Arrow.TYPE_NO_TYPE,Arrow.TYPE_NO_TYPE);
		private var activeCombo:String;
		private var indexC:int = 0;
		
		
		/*******************
		 * Constructor
		 *******************/
		public function Nivel(level:int, type:String, victory:String) 
		{
			trace("Nivel " + level + " cargado, de tipo: " + type);
			datosNivel = new DatosNivel(level);
			
			levelNumber = level;
			levelType = type;
			victoryType = victory;
			numVidas = datosNivel.Vidas;
			
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
			restanteInicioTxt = new TextField(300, 300, String(3), Assets.getFont("FontLevel").name, 100, 0xffffff);
			imgMuralla = new Image(Assets.getAtlas("gameSprite").getTexture("Muralla_" + levelType));
			
			barraImg = new Image(Assets.getAtlas("gameSprite").getTexture("Barra"));
			vidasImg = new Image(Assets.getAtlas("gameSprite").getTexture("Corazon"));
			relojImg = new Image(Assets.getAtlas("gameSprite").getTexture("Reloj"));
			
			tiempoTxt = new TextField(50, 20, "0:00", Assets.getFont("Textos").name, 20, 0x000000);
			vidasTxt = new TextField(50, 20, String(numVidas), Assets.getFont("Textos").name, 20, 0x000000);
			puntosTxt = new TextField(50, 20, "0000", Assets.getFont("Textos").name, 20, 0x000000);
			
			//El tiempo en el modo de timepo se cuenta de forma inversa
			if (victoryType == "time")
			{
				//Tiempo
				min = datosNivel.TiempoVictoria / 60;
				sec = datosNivel.TiempoVictoria - min * 60;
				if (sec < 10)
					tiempoTxt.text = min + ":0" + sec;
				else
					tiempoTxt.text = min + ":" + sec;
			}
			
			tiempoTxt.x = stage.stageWidth - tiempoTxt.width;
			relojImg.x = tiempoTxt.x - relojImg.width/2;
			
			vidasTxt.x = stage.stageWidth - tiempoTxt.width - tiempoTxt.width;
			vidasImg.x = vidasTxt.x
			
			puntosTxt.x = stage.x;
			
			barraImg.x = stage.x;
			
			tiempoTxt.y = puntosTxt.y = vidasTxt.y = stage.y - 3;
			
			this.addChild(imgMuralla);
			
			//PLATAFORMAS
			for (var i:int = 0; i < datosNivel.Soldados.length; i++)
			{
				var platf:Plataforma = new Plataforma(datosNivel.Soldados[i][0], datosNivel.Soldados[i][1], datosNivel.Soldados[i][3], datosNivel.Soldados[i][2]);
				soldierArray.push(platf);
				trace("\t x:"+datosNivel.Soldados[i][0] + ", y:" + datosNivel.Soldados[i][1] + ", a:" + datosNivel.Soldados[i][2] + ", p:" + datosNivel.Soldados[i][3]);
				addChild(platf);
			}
			
			this.addChild(barraImg);
			this.addChild(vidasImg);
			this.addChild(relojImg);
			
			this.addChild(vidasTxt);
			this.addChild(tiempoTxt);
			this.addChild(puntosTxt);
			this.addChild(restanteInicioTxt);
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
				this.removeChild(restanteInicioTxt);
				this.removeEventListener(Event.ENTER_FRAME, prepareGameTick);
				empezar();
			}
			else if (int(tiempoTrascurrido / 60) == 3)
			{
				restanteInicioTxt.text = "GO!";
			}
			else
			{
				restanteInicioTxt.text = String(3 - int(tiempoTrascurrido / 60));
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
			vidasTxt.text = String(numVidas);
			
			if (numPuntos < 10)
				puntosTxt.text = "000" + numPuntos;
			else if (numPuntos < 100)
				puntosTxt.text = "00" + numPuntos;
			
			tiempoTrascurrido += 1;
			arrowTimer += 1;
			
			//Condicion de derrota general (quedarse sin vidas)
			if (numVidas == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, onGameTick);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "endlvl", lvl: levelNumber, stars: 0, type: levelType, vic: victoryType, go: true }, true));
			}
			
			//MODOS DE JUEGO
			if (victoryType == "time")
			{
				//Temporizador inverso
				min = (datosNivel.TiempoVictoria - int(tiempoTrascurrido / 60)) / 60;
				sec = (datosNivel.TiempoVictoria - int(tiempoTrascurrido / 60)) - min * 60;
				if (sec < 10)
					tiempoTxt.text = min + ":0" + sec;
				else
					tiempoTxt.text = min + ":" + sec;
				
				//Condicion de victoria
				if (int(tiempoTrascurrido / 60) == datosNivel.TiempoVictoria)
				{
					//Calcular estrellas conseguidas
					var starEarned:int = 1;
					if (numVidas == datosNivel.Vidas)
						++starEarned;
					if (numPuntos > datosNivel.PuntosVictoria)
						++starEarned;
					
					//Guardar partida
					save(starEarned);
					
					//Detener el juego y abrir ventana final
					this.removeEventListener(Event.ENTER_FRAME, onGameTick);
					this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "endlvl", lvl: levelNumber, stars: starEarned, type: levelType, vic: victoryType, go: false }, true));
				}
			}
			else
			{
				//Tiempo normal
				min = int(tiempoTrascurrido / 60) / 60;
				sec = int(tiempoTrascurrido / 60) - min * 60;
				if (sec < 10)
					tiempoTxt.text = min + ":0" + sec;
				else
					tiempoTxt.text = min + ":" + sec;
			}
			
			//Lógica general para todos los modos de juego
			if (arrowTimer / 60 > nextArrowDelay)
			{
				spawnArrow();
				arrowTimer = 0;
			}
			
			//Mover flechas y comprobar sus estados (romper con el dedo, colisiones con plataformas, etc)
			for (var a:int = 0; a < arrowArray.length; ++a)
			{
				if (arrowArray[a].Status == Arrow.STATUS_DESTROY)
				{
					trace("Flecha de tipo " + arrowArray[a].Tipo + " destruida.");
					switch(arrowArray[a].Tipo)
					{
						//Puntos
						case Arrow.TYPE_NORMAL:
							++numPuntos;
							break;
						case Arrow.TYPE_ELECTRIC:
						case Arrow.TYPE_FIRE:
						case Arrow.TYPE_ICE:
						case Arrow.TYPE_PLANT:
							numPuntos += 5;
							break;
						case Arrow.TYPE_FAST:
							numPuntos += 10;
							break;
					}
					
					a = deleteArrow(a);
				}
				else if (arrowArray[a].Status == Arrow.STATUS_GET)
				{
					checkCombos(arrowArray[a].Tipo);
					
					//trace(activeCombo);
					
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
								if (!(soldierArray[s].SoldierArmor == 3 && arrowArray[a].Tipo == Arrow.TYPE_FIRE))
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
			--numVidas;
		}
		
		private function save(stars:int):void 
		{
			Game.saveGame.setProperty(datosNivel.Numero + "_stars", stars);
			Game.saveGame.setProperty(datosNivel.Numero + 1 + "_lock", false);
			
			Game.saveGame.flush();
		}
		
		private function checkCombos(tipo:String):void
		{
			//Reiniciar si se ha hecho un combo
			if(activeCombo != Arrow.TYPE_NO_TYPE)
			{
				activeCombo = Arrow.TYPE_NO_TYPE;
				for (var k:int = 0; k < combo.length; k++)
					combo[k] = Arrow.TYPE_NO_TYPE;
			}
			
			//añadir flecha al array
			combo[indexC] = tipo;
			
			//contadores
			var normal:int = 0;
			var fast:int = 0;
			var fire:int = 0;
			var elec:int = 0;
			
			//invertir array para definir el orden
			var comboInv:Array = new Array();
			for (var j:int = 0; j < combo.length; j++)
				comboInv[j] = combo[2 - j];
			
			trace("--------------------------------");
			
			//Comprobar las 3 ultimas flechas recogidas
			for (var i:int = 0; i < 3; i++)
			{
				trace((2 - indexC + i) % 3, comboInv[(2 - indexC + i) % 3]);
				//Contar tipos de flechas
				switch(comboInv[(2 - indexC + i) % 3])
				{
					case Arrow.TYPE_NORMAL:
						++normal;
						break;
					case Arrow.TYPE_FIRE:
						++fire;
						break;
					case Arrow.TYPE_FAST:
						++fast;
						break;
					case Arrow.TYPE_ELECTRIC:
						++elec;
						break;
				}
				
				//Combos
				if (fire == 1 && elec == 1)
				{
					activeCombo = Arrow.TYPE_FIRE_ELEC;
					break;
				}
				else if (fast == 1 && elec == 1)
				{
					activeCombo = Arrow.TYPE_ELECTRIC;
					break;
				}
				else if (normal == 2 && fire == 1)
				{
					activeCombo = Arrow.TYPE_FIRE;
				}
				else if (normal == 2 && fast == 1)
				{
					activeCombo = Arrow.TYPE_FIRE;
				}
			}
			trace("active:", activeCombo);
			
			//Cambiar al siguiente indice
			indexC = ++indexC % 3;
		}
	}
}