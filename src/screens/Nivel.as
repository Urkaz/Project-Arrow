package screens 
{
	import events.NavigationEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import objects.Arrow;
	import objects.Plataforma;
	import objects.Soldado;
	import objects.Warning;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import utils.DatosNivel;
	import starling.events.Event;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.utils.Color;
	import starling.events.KeyboardEvent;
	
	
	/*
	 * CONDICIONES DE VICTORIA
	 * Tiempo
	 * 1- Completar el nivel
	 * 2- Puntuacion mínima
	 * 3- Sin morir
	 * 
	 * Vida
	 * 1- Completar el nivel
	 * 2- Puntuacion mínima
	 * 3- Tiempo mínimo para conseguir objetivo
	 * 
	 * Combos
	 * 1- Completar el nivel
	 * 2- Sin morir
	 * 3- Tiempo mínimo para conseguir objetivo y puntuacion mínima
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
		private var healthImg:Image;
		
		private var fogImg:Image;
		
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
		
		private var paused:Boolean = false;
		
		private var numVidas:int;
		private var vidasTxt:TextField;
		
		private var numPuntos:int = 0;
		private var puntosTxt:TextField;
		
		private var numSaludMuralla:int = 0;
		private var healthTxt:TextField;
		
		private var combo:Array = new Array(Arrow.TYPE_NO_TYPE,Arrow.TYPE_NO_TYPE,Arrow.TYPE_NO_TYPE);
		private var activeCombo:String = Arrow.TYPE_NO_TYPE;
		private var indexCombo:int = 0;
		
		private var comboVictory:Array;
		private var comboInterfaz:Array = new Array();
		
		private var starEarned:int = 1;
		
		private var pausaBtn:Button;
		
		private var interfaz:Sprite = new Sprite();
		
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
			numSaludMuralla = datosNivel.SaludVictoria;
			
			if (victoryType == "combo")
				comboVictory = datosNivel.CombosVictoria;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*******************
		 * Funciones
		 *******************/
		private function onAddedToStage(event:Event):void
		{
			drawGame();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function drawGame():void
		{
			restanteInicioTxt = new TextField(300, 300, String(3), Assets.getFont("FontLevel").name, 100, 0xffffff);
			imgMuralla = new Image(Assets.getAtlas("gameSprite").getTexture("Muralla_" + levelType));
			pausaBtn = new Button(Assets.getAtlas("gameSprite").getTexture("Pausa"));
			
			barraImg = new Image(Assets.getAtlas("gameSprite").getTexture("Barra"));
			vidasImg = new Image(Assets.getAtlas("gameSprite").getTexture("Corazon"));
			relojImg = new Image(Assets.getAtlas("gameSprite").getTexture("Reloj"));
			
			tiempoTxt = new TextField(40, 20, "0:00", Assets.getFont("Textos").name, 20, 0x000000);
			vidasTxt = new TextField(20, 20, String(numVidas), Assets.getFont("Textos").name, 20, 0x000000);
			puntosTxt = new TextField(40, 20, "0000", Assets.getFont("Textos").name, 20, 0x000000);
			
			pausaBtn.x = stage.stageWidth - pausaBtn.width + 2;
			
			restanteInicioTxt.x = stage.stageWidth / 2 - restanteInicioTxt.width / 2;
			restanteInicioTxt.y = stage.stageHeight / 2 - restanteInicioTxt.height / 2;
		
			
			tiempoTxt.x = pausaBtn.x - tiempoTxt.width;
			relojImg.x = tiempoTxt.x - relojImg.width + 5;
			
			vidasTxt.x = relojImg.x - vidasTxt.width;
			vidasImg.x = vidasTxt.x - vidasImg.width + 8;
			
			puntosTxt.x = stage.x;
			
			barraImg.x = stage.x;
			
			tiempoTxt.y = puntosTxt.y = vidasTxt.y = stage.y - 3;
			pausaBtn.y = stage.y - 2;
			
			//Añadir la imagen de fondo
			this.addChild(imgMuralla);
			
			//INTERFAZ
			interfaz.addChild(barraImg);

			//El tiempo en el modo de tiempo se cuenta de forma inversa
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
			else if (victoryType == "lives")
			{
				healthTxt = new TextField(50, 20, String(numSaludMuralla), Assets.getFont("Textos").name, 20, 0x000000);
				healthImg = new Image(Assets.getAtlas("gameSprite").getTexture("Salud_Muralla"));
				
				healthTxt.y = tiempoTxt.y;
				healthImg.x = puntosTxt.x + puntosTxt.width + 30;
				healthTxt.x = healthImg.x + healthImg.width - 10;
				
				interfaz.addChild(healthImg);
				interfaz.addChild(healthTxt);
			}
			else if (victoryType == "combo")
			{
				for (var j:int = 0; j < comboVictory.length; j++)
				{
					var miniIcon:Image = new Image(Assets.getAtlas("gameSprite").getTexture("Flecha_" + comboVictory[j][0]));
					if (comboVictory[j][0] == Arrow.TYPE_C_FIRE)
						miniIcon.color = Color.RED
					else if (comboVictory[j][0] == Arrow.TYPE_C_ELECTRIC)
						miniIcon.color = Color.YELLOW;
					else if (comboVictory[j][0] == Arrow.TYPE_C_FAST)
						miniIcon.color = Color.PURPLE;
					else if (comboVictory[j][0] == Arrow.TYPE_C_FIRE_ICE)
						miniIcon.color = Color.AQUA;
					
					var textCombo:TextField = new TextField(20, 20, comboVictory[j][1], Assets.getFont("Textos").name, 20, 0x000000);
					
					comboInterfaz.push(new Array(miniIcon,textCombo,comboVictory[j][1]));
					
					miniIcon.x = puntosTxt.x + puntosTxt.width + 20 + 40 * j;
					textCombo.x = miniIcon.x + miniIcon.width - textCombo.width / 2 + 5;
					
					textCombo.y = tiempoTxt.y;
					
					interfaz.addChild(miniIcon);
					interfaz.addChild(textCombo);
				}
			}
			
			interfaz.addChild(pausaBtn);
			
			interfaz.addChild(vidasImg);
			interfaz.addChild(relojImg);
			
			interfaz.addChild(vidasTxt);
			interfaz.addChild(tiempoTxt);
			interfaz.addChild(puntosTxt);
			
			//PLATAFORMAS
			for (var i:int = 0; i < datosNivel.Soldados.length; i++)
			{
				var platf:Plataforma = new Plataforma(datosNivel.Soldados[i][0], datosNivel.Soldados[i][1], datosNivel.Soldados[i][3], datosNivel.Soldados[i][2]);
				soldierArray.push(platf);
				this.addChild(platf);
			}
			
			//Niveles con niebla
			if (datosNivel.isFogPanel)
			{
				fogImg = new Image(Assets.getAtlas("gameSprite").getTexture("Niebla"));
				fogImg.y = barraImg.height - 1;
				fogImg.touchable = false;
				this.addChild(fogImg);
			}
			
			this.addChild(interfaz);
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
			
			//Eventos de pausar el juego
			this.addEventListener(KeyboardEvent.KEY_DOWN, pausaTeclado);
			this.addEventListener(Event.TRIGGERED, pausaClick);
			
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
			var newArrow:Arrow = new Arrow(datosNivel.Flechas[0][arrowIndex], datosNivel.Flechas[2][arrowIndex]);
			
			this.addChild(newArrow);
			
			this.swapChildren(newArrow, interfaz); //Poner la interfaz delante
			if (datosNivel.isFogPanel) //Si hay niebla, ponerla delante
				this.swapChildren(newArrow, fogImg);
			
			//Recalcular tiempo para el spawn de la siguiente flecha
			//Calcular tiempo random de spawn de la siguiente flecha
			nextArrowDelay = Math.floor(Math.random() * (datosNivel.TimeSpawnMax*10 - datosNivel.TimeSpawnMin*10 + 1)) + datosNivel.TimeSpawnMin*10;
			nextArrowDelay /= 10
			
			var alerta:Warning = new Warning();
			if (datosNivel.Flechas[0][arrowIndex] != Arrow.TYPE_NORMAL)
			{
				alerta.x = newArrow.x + newArrow.width / 2 - alerta.width / 2;
				alerta.y = barraImg.height;
				
				this.addChild(alerta);
			}
			
			arrowArray.push(new Array(newArrow,alerta));
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
			//Vidas y puntos
			vidasTxt.text = String(numVidas);
			
			if (numPuntos < 10)
				puntosTxt.text = "000" + numPuntos;
			else if (numPuntos < 100)
				puntosTxt.text = "00" + numPuntos;
			else if (numPuntos < 1000)
				puntosTxt.text = "0" + numPuntos;
			else
				puntosTxt.text = String(numPuntos);
			
			tiempoTrascurrido += 1;
			arrowTimer += 1;
			
			//Condicion de derrota general (quedarse sin vidas)
			if (numVidas == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, onGameTick);
				this.removeEventListener(KeyboardEvent.KEY_DOWN, pausaTeclado);
				this.removeEventListener(Event.TRIGGERED, pausaClick);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "endlvl", lvl: levelNumber, stars: 0, type: levelType, vic: victoryType, go: true }, true));
			}
			
			//MODOS DE JUEGO
			//MODO Tiempo
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
					if (numVidas == datosNivel.Vidas)
						++starEarned;
					if (numPuntos >= datosNivel.PuntosVictoria)
						++starEarned;
					
					//Guardar partida
					save(starEarned);
					
					//Detener el juego y abrir ventana final
					this.removeEventListener(Event.ENTER_FRAME, onGameTick);
					this.removeEventListener(KeyboardEvent.KEY_DOWN, pausaTeclado);
					this.removeEventListener(Event.TRIGGERED, pausaClick);
					this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "endlvl", lvl: levelNumber, stars: starEarned, type: levelType, vic: victoryType, go: false }, true));
				}
			}
			else //Otros
			{
				//Tiempo normal
				min = int(tiempoTrascurrido / 60) / 60;
				sec = int(tiempoTrascurrido / 60) - min * 60;
				if (sec < 10)
					tiempoTxt.text = min + ":0" + sec;
				else
					tiempoTxt.text = min + ":" + sec;
				
				//MODO Salud enemigo
				if (victoryType == "lives")
				{
					if(numSaludMuralla > 0)
						healthTxt.text = String(numSaludMuralla);
					else
						healthTxt.text = String(0);
						
					//Condicion de victoria
					if (numSaludMuralla <= 0)
					{
						//Calcular estrellas conseguidas
						if (tiempoTrascurrido <= datosNivel.TiempoVictoria * 60)
							++starEarned;
						if (numPuntos >= datosNivel.PuntosVictoria)
							++starEarned;
						
						//Guardar partida
						save(starEarned);
						//Detener el juego y abrir ventana final
						this.removeEventListener(Event.ENTER_FRAME, onGameTick);
						this.removeEventListener(KeyboardEvent.KEY_DOWN, pausaTeclado);
						this.removeEventListener(Event.TRIGGERED, pausaClick);
						this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "endlvl", lvl: levelNumber, stars: starEarned, type: levelType, vic: victoryType, go: false }, true));
					}
				}
				//MODO combos
				else if (victoryType == "combo")
				{
					//Restar y comprobar combos
					var victoryCheck:int = 0;
					for (var i:int = 0; i < comboVictory.length; i++)
					{
						//Restar combos
						if (activeCombo == comboVictory[i][0])
						{
							if (comboInterfaz[i][2] > 0)
							{
								comboInterfaz[i][1].text = --comboInterfaz[i][2];
							}
						}
						
						if (comboInterfaz[i][2] == 0)
								++victoryCheck;
					}
					
					//Condicion de victoria
					if (victoryCheck == comboVictory.length)
					{
						//Calcular estrellas conseguidas
						if (numVidas == datosNivel.Vidas)
							++starEarned;
						if (numPuntos >= datosNivel.PuntosVictoria && tiempoTrascurrido <= datosNivel.TiempoVictoria * 60)
							++starEarned;
						
						//Guardar partida
						save(starEarned);
						//Detener el juego y abrir ventana final
						this.removeEventListener(Event.ENTER_FRAME, onGameTick);
						this.removeEventListener(KeyboardEvent.KEY_DOWN, pausaTeclado);
						this.removeEventListener(Event.TRIGGERED, pausaClick);
						this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "endlvl", lvl: levelNumber, stars: starEarned, type: levelType, vic: victoryType, go: false }, true));
					}
				}
			}
			
			//Lógica general para todos los modos de juego
			resetCombos();
			
			//Spawn de flechas
			if (arrowTimer / 60 > nextArrowDelay)
			{
				spawnArrow();
				arrowTimer = 0;
			}
			
			//Mover flechas y comprobar sus estados (romper con el dedo, colisiones con plataformas, etc)
			for (var a:int = 0; a < arrowArray.length; ++a)
			{
				//Comprobar los objetos Warning de las flechas para eliminarlos de la escena
				if (arrowArray[a][0].Tipo != Arrow.TYPE_NORMAL && arrowArray[a][0].y + arrowArray[a][0].height >= arrowArray[a][1].y)
				{
					arrowArray[a][1].destroy();
					this.removeChild(arrowArray[a][1]);
				}
				
				
				//Tocada durante la caida por la muralla
				if (arrowArray[a][0].Status == Arrow.STATUS_DESTROY)
				{
					trace("Flecha de tipo " + arrowArray[a][0].Tipo + " destruida.");
					calcularPuntos(arrowArray[a][0].Tipo);
					
					a = deleteArrow(a);
				}
				//Tocada en el panel
				else if (arrowArray[a][0].Status == Arrow.STATUS_GET)
				{
					//Combos
					checkCombos(arrowArray[a][0].Tipo);
					
					//Puntos
					if(arrowArray[a][0].Tipo != Arrow.TYPE_PLANT)
						calcularPuntos(arrowArray[a][0].Tipo, 2);
					calcularPuntos(activeCombo);
					
					a = deleteArrow(a);
				}
				else
				{
					arrowArray[a][0].y += arrowArray[a][0].Velocidad;
					
					//Si está fuera del escenario, borrar
					if (arrowArray[a][0].y > stage.stageHeight)
					{
						a = deleteArrow(a);
					}
					else //Si no, se comprueban las colisiones
					{
						//Recorrer plataformas (soldados)
						for (var s:int = 0; s < soldierArray.length; ++s)
						{
							var puntaFlecha:Point = new Point(arrowArray[a][0].x + arrowArray[a][0].width / 2, arrowArray[a][0].y + arrowArray[a][0].height);
							var center:Point = new Point(soldierArray[s].SoldierGlobalX + soldierArray[s].SoldierWidth / 2, soldierArray[s].SoldierGlobalY + soldierArray[s].SoldierHeight / 2);
							var rad:Number = soldierArray[s].SoldierWidth / 2;
							
							var dist:Number = Point.distance(center, puntaFlecha);
							
							if (dist < rad)
							{
								//Si el soldado tiene armadura de nivel 3 (contra el fuego) no se le reducirá.
								if (!(soldierArray[s].SoldierArmor == 3 && arrowArray[a][0].Tipo == Arrow.TYPE_FIRE))
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
		
		//Cambiar el return?
		private function deleteArrow(index:int):int
		{
			var aux:Array = arrowArray[index];
			arrowArray[index] = arrowArray[arrowArray.length - 1];
			arrowArray[arrowArray.length - 1] = aux;
			
			aux[0].destroy();
			
			this.removeChild(aux[0]);
			arrowArray.pop()
			
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
			if(starEarned > Game.saveGame.data[levelNumber + "_stars"])
				Game.saveGame.setProperty(levelNumber + "_stars", stars);
			
			Game.saveGame.setProperty(levelNumber + "_puntos", numPuntos);
			Game.saveGame.setProperty(levelNumber + "_vidas", numVidas);
			Game.saveGame.setProperty(levelNumber + "_salud", numSaludMuralla);
			Game.saveGame.setProperty(levelNumber + "_tiempo", tiempoTrascurrido);
			
			//Siguiente
			Game.saveGame.setProperty((levelNumber + 1) + "_lock", false);
			if(Game.saveGame.data[(levelNumber + 1) + "_stars"] == undefined)
				Game.saveGame.setProperty((levelNumber + 1) + "_stars", 0);
			
			Game.saveGame.flush();
		}
		
		private function pausaTeclado(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.P && !paused)
			{
				paused = true;
				this.removeEventListener(Event.ENTER_FRAME, onGameTick);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "pause", lvl: levelNumber, stars: starEarned, type: levelType, vic: victoryType }, true));
				//Enviar evento ventana pausa
			}
			else if(event.keyCode == Keyboard.P && paused)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "close" }, true));
				unPause();
				//Enviar evento de cierre ventana pausa
			}
		}
		
		private function pausaClick(e:Event):void
		{
			var buttonClicked:Button = e.target as Button;
			if ((buttonClicked as Button) == pausaBtn && !paused)
			{
				paused = true;
				this.removeEventListener(Event.ENTER_FRAME, onGameTick);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "pause", lvl: levelNumber, stars: starEarned, type: levelType, vic: victoryType }, true));
			}
		}
		
		public function unPause():void
		{
			paused = false;
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		private function resetCombos():void
		{
			if(activeCombo != Arrow.TYPE_NO_TYPE)
			{
				trace("resetCombos");
				activeCombo = Arrow.TYPE_NO_TYPE;
				for (var k:int = 0; k < combo.length; k++)
					combo[k] = Arrow.TYPE_NO_TYPE;
			}
		}
		
		private function checkCombos(tipo:String):void
		{
			resetCombos();
			
			//añadir flecha al array
			combo[indexCombo] = tipo;
			
			//contadores
			var normal:int = 0;
			var fast:int = 0;
			var fire:int = 0;
			var elec:int = 0;
			var ice:int = 0;
			
			//invertir array para definir el orden
			var comboInv:Array = new Array();
			for (var j:int = 0; j < combo.length; j++)
				comboInv[j] = combo[2 - j];
			
			trace("--------------------------------");
			
			//Comprobar las 3 ultimas flechas recogidas
			for (var i:int = 0; i < 3; i++)
			{
				trace((2 - indexCombo + i) % 3, comboInv[(2 - indexCombo + i) % 3]);
				//Contar tipos de flechas
				switch(comboInv[(2 - indexCombo + i) % 3])
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
					case Arrow.TYPE_ICE:
						++ice;
						break;
				}
				
				//Combos
				if (fire == 1 && elec == 1)
				{
					activeCombo = Arrow.TYPE_C_FIRE_ELEC;
					break;
				}
				else if (fast == 1 && elec == 1)
				{
					activeCombo = Arrow.TYPE_C_ELECTRIC;
					break;
				}
				else if (fire == 1 && ice == 1)
				{
					activeCombo = Arrow.TYPE_C_FIRE_ICE;
					break;
				}
				else if (normal == 2 && fire == 1)
				{
					activeCombo = Arrow.TYPE_C_FIRE;
				}
				else if (normal == 2 && fast == 1)
				{
					activeCombo = Arrow.TYPE_C_FAST;
				}
			}
			trace("active:", activeCombo);
			
			//Cambiar al siguiente indice
			indexCombo = ++indexCombo % 3;
		}
		
		//Puntos y salud
		private function calcularPuntos(tipo:String, multip:int = 1):void
		{
			switch(tipo)
			{
				//Puntos normales
				case Arrow.TYPE_NORMAL:
					numPuntos += 1 * multip;
					break;
				case Arrow.TYPE_ELECTRIC:
				case Arrow.TYPE_FIRE:
				case Arrow.TYPE_ICE:
				case Arrow.TYPE_PLANT:
					numPuntos += 5 * multip;
					break;
				case Arrow.TYPE_FAST:
					numPuntos += 10 * multip;
					break;
				//Puntos de los combos (SIN MULTIPLICADOR)
				case Arrow.TYPE_C_FAST:
				case Arrow.TYPE_C_FIRE:
					numPuntos += 40;
					numSaludMuralla -= 20;
					break;
				case Arrow.TYPE_C_FIRE_ICE:
				case Arrow.TYPE_C_FIRE_ELEC:
				case Arrow.TYPE_C_ELECTRIC:
					numPuntos += 50;
					numSaludMuralla -= 40;
					break;
			}
		}
		
		//Metodo a llamar cuando se vuelva al menú. Necesario para que se eliminen las partículas del juggler
		public function exitDestroy():void
		{
			trace("exitDestroy");
			for (var i:int = arrowArray.length-1; i > -1; i--)
			{
				deleteArrow(i);
			}
		}
	}
}