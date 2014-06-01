package objects 
{
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import utils.Assets;
	import utils.DatosNivel;
	import utils.Textos;
	import utils.VentanaBase;
	
	public class VentanaFinal extends VentanaBase
	{
		//private var descrip:TextField;
		
		private var stars:Image;
		private var replayBtn:Button;
		private var menuBtn:Button;
		
		private var datosNivel:DatosNivel;
		
		private var resultados:TextField;
		private var puntosTxt:TextField;
		private var vidasTxt:TextField;
		private var puntosRes:TextField;
		private var vidasRes:TextField;
		
		private var tiempoTxt:TextField;
		private var tiempoRes:TextField;
		
		private var descrip:TextField;
		
		private var numPuntos:int = 0;
		private var numTiempo:int = 0;
		private var min:int = 0;
		private var sec:int = 0;
		private var numVidas:int = 0;
		
		public function VentanaFinal(numLvl:int, starsCount:int, type:String, victoryType:String, stage:Stage, gameOver:Boolean)
		{
			datosNivel = new DatosNivel(numLvl);
			
			super(numLvl, starsCount, type, victoryType, stage);
			
			numPuntos = Game.saveGame.data[numLvl + "_puntos"];
			numTiempo = Game.saveGame.data[numLvl + "_tiempo"];
			numVidas = Game.saveGame.data[numLvl + "_vidas"];
			
			replayBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_repetir"));
			menuBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_menu"));
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			//Posiciones
			replayBtn.x = menuBtn.x = selector.x + selector.width / 2 - replayBtn.width / 2;
			replayBtn.x -= 100;
			menuBtn.x += 100;
			replayBtn.y = menuBtn.y = selector.y + selector.height - replayBtn.height - 12;
			
			stars.x = selector.x + selector.width / 2 - stars.width / 2;
			stars.y = mainTxt.y + mainTxt.height - 20;
			
			if (!gameOver)
			{
				resultados = new TextField(250, 30, Textos.FINAL_RESULTS, Assets.getFont("Textos").name, 30, 0xffffff);
			
				puntosTxt = new TextField(100, 30, Textos.FINAL_POINTS, Assets.getFont("Textos").name, 30, 0xffffff);
				puntosRes = new TextField(100, 30, "", Assets.getFont("Textos").name, 30, 0xffffff);
				
				puntosRes.hAlign = puntosTxt.hAlign = puntosRes.hAlign = HAlign.LEFT;
				
				if (numPuntos < 10)
					puntosRes.text = "000" + numPuntos;
				else if (numPuntos < 100)
					puntosRes.text = "00" + numPuntos;
				else if (numPuntos < 1000)
					puntosRes.text = "0" + numPuntos;
				else
					puntosRes.text = String(numPuntos);
				
				
				resultados.x = selector.x + selector.width / 2 - resultados.width / 2;
				resultados.y = stars.y + stars.height + 20 - resultados.height / 2;
				
				puntosTxt.x = resultados.x + 25;
				puntosRes.x = resultados.x + resultados.width - puntosRes.width - 25;
				
				puntosTxt.y = resultados.y + resultados.height;
				puntosRes.y = puntosTxt.y;
				
				if (numPuntos >= datosNivel.PuntosVictoria)
					puntosRes.color = Color.rgb(192, 255, 0);
				else
					puntosRes.color = Color.rgb(223, 89, 89);
					
				this.addChild(resultados);
				this.addChild(puntosTxt);
				this.addChild(puntosRes);
				
				mainTxt.text = Textos.FINAL_VICTORY;
				
				//MODOS DE JUEGO
				if (victoryType == "time")
				{
					vidasTxt = new TextField(100, 30, Textos.FINAL_LIVES, Assets.getFont("Textos").name, 30, 0xffffff);
					vidasRes = new TextField(100, 30, String(numVidas), Assets.getFont("Textos").name, 30, 0xffffff);
					
					//Color
					if (numVidas == datosNivel.Vidas)
						vidasRes.color = Color.rgb(192, 255, 0);
					else
						vidasRes.color = Color.rgb(223, 89, 89);
					
					vidasTxt.x = puntosTxt.x;
					vidasRes.x = resultados.x + resultados.width - puntosRes.width - 25;
					
					vidasTxt.y = puntosTxt.y + puntosTxt.height;
					vidasRes.y = vidasTxt.y;
					
					vidasRes.hAlign = vidasTxt.hAlign = HAlign.LEFT;
					
					this.addChild(vidasTxt);
					this.addChild(vidasRes);
				}
				else
				{
					tiempoTxt = new TextField(100, 30, Textos.FINAL_TIME, Assets.getFont("Textos").name, 30, 0xffffff);
					tiempoRes = new TextField(100, 30, "", Assets.getFont("Textos").name, 30, 0xffffff);
					
					vidasTxt = new TextField(100, 30, Textos.FINAL_LIVES, Assets.getFont("Textos").name, 30, 0xffffff);
					vidasRes = new TextField(100, 30, String(numVidas), Assets.getFont("Textos").name, 30, 0xffffff);
					
					//Tiempo
					min = int(numTiempo / 60) / 60;
					sec = int(numTiempo / 60) - min * 60;
					if (sec < 10)
						tiempoRes.text = min + ":0" + sec;
					else
						tiempoRes.text = min + ":" + sec;
					
					//Color tiempo
					if (numTiempo <= datosNivel.TiempoVictoria * 60)
						tiempoRes.color = Color.rgb(192, 255, 0);
					else
						tiempoRes.color = Color.rgb(223, 89, 89);
					
					//Color vidas
					if (numVidas == datosNivel.Vidas)
						vidasRes.color = Color.rgb(192, 255, 0);
					else
						vidasRes.color = Color.rgb(223, 89, 89);
					
					vidasTxt.y = puntosTxt.y + puntosTxt.height;
					vidasRes.y = vidasTxt.y;
					
					tiempoTxt.y = vidasTxt.y + vidasTxt.height
					tiempoRes.y = tiempoTxt.y;
					
					vidasTxt.x = tiempoTxt.x = puntosTxt.x;
					
					vidasRes.x = tiempoRes.x = resultados.x + resultados.width - puntosRes.width - 25;
					
					tiempoRes.hAlign = tiempoTxt.hAlign = vidasRes.hAlign = vidasTxt.hAlign = HAlign.LEFT;
					
					this.addChild(tiempoTxt);
					this.addChild(tiempoRes);
					this.addChild(vidasTxt);
					this.addChild(vidasRes);
				}
			}
			else
			{
				descrip = new TextField(250, 100, Textos.FINAL_GAMEOVER_DESCRIP , Assets.getFont("Textos").name, 30, 0xffffff);
				
				descrip.x = selector.x + selector.width / 2 - descrip.width / 2;
				descrip.y = stars.y + stars.height + 20;
				
				this.addChild(descrip);
				
				mainTxt.text = Textos.FINAL_GAMEOVER;
			}
			
			this.addChild(replayBtn);
			this.addChild(menuBtn);
			this.addChild(stars);
			
			this.addEventListener(Event.TRIGGERED, buttonClick);
		}
		
		private function buttonClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == menuBtn)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "close" , cs: true, nav_ev: "menu"}, true));
			}
			else if((buttonClicked as Button) == replayBtn)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: numLvl, type: type, vic: victory }, true));
			}
		}
	}

}
