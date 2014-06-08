package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import utils.Assets;
	import events.NavigationEvent;
	import utils.Textos;
	
	public class Home extends Sprite 
	{
		
		private var boton_playHome:Button;
		private var boton_borrarPartida:Button;
		private var boton_instrucciones:Button;
		private var boton_idioma_es:Button;
		private var boton_idioma_en:Button;
		
		private var texto:TextField;
		
		private var fondo_home:Image;
		
		public function Home() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Cargado menú principal")
			drawScreen();
		}
		
		private function drawScreen():void
		{
			fondo_home = new Image(Assets.getTexture("PantallaInicial"));
			this.addChild(fondo_home)
			
			boton_playHome = new Button(Assets.getAtlas("botones_"+Textos.LANG).getTexture("PlayInicial"));
			boton_borrarPartida = new Button(Assets.getAtlas("botones_"+Textos.LANG).getTexture("borrar"));
			boton_instrucciones = new Button(Assets.getAtlas("botones_" + Textos.LANG).getTexture("Instr"));
			
			boton_idioma_en = new Button(Assets.getAtlas("botones_" + Textos.LANG).getTexture("lang_" + Textos.ENGLISH));
			boton_idioma_es = new Button(Assets.getAtlas("botones_" + Textos.LANG).getTexture("lang_" + Textos.SPANISH));
			
			texto = new TextField(boton_idioma_es.width, 100, "" , Assets.getFont("Textos").name, 20, 0xffffff);
			
			if(Textos.LANG == Textos.SPANISH)
				this.addChild(boton_idioma_en);
			else if(Textos.LANG == Textos.ENGLISH)
				this.addChild(boton_idioma_es);
			
			boton_playHome.x = stage.stageWidth / 2 - boton_playHome.width / 2;
			boton_playHome.y = 350;
			
			boton_borrarPartida.x = stage.x + 3;
			boton_instrucciones.x = boton_borrarPartida.x + boton_borrarPartida.width + 3;
			boton_idioma_es.x = boton_idioma_en.x = boton_instrucciones.x + boton_instrucciones.width + 3;
			
			boton_idioma_en.y = boton_idioma_es.y = boton_instrucciones.y = boton_borrarPartida.y = stage.stageHeight - boton_borrarPartida.height - 7;
			
			texto.y = boton_idioma_en.y - texto.height;
			texto.x = boton_idioma_en.x + boton_idioma_en.width / 2 -texto.width / 2;
			
			this.addChild(boton_playHome);
			this.addChild(boton_borrarPartida);
			this.addChild(boton_instrucciones);
			this.addChild(texto);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == boton_playHome)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			else if((buttonClicked as Button) == boton_instrucciones)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "instruc"}, true));
			}
			else if ((buttonClicked as Button) == boton_borrarPartida)
			{
				var lang_aux:String = Game.saveGame.data["lang"]; //Mantener el idioma al borrar la partida
				
				Game.saveGame.clear();
				
				trace("2:>" + new Error().getStackTrace().match(/(?<=:)[0-9]*(?=])/g)[0], "Home: CAMBIAR NIVEL INICIAL AL QUE SE EMPEIZA LA PARTIDA AL NUM 1, EL 0 ES EL DE PRUEBA!!!!");
				if (Game.saveGame.data[0 + "_lock"] == undefined)
				{
					Game.saveGame.setProperty(0 + "_lock", false);
					Game.saveGame.setProperty(0 + "_stars", 0);
					Game.saveGame.setProperty("lang", lang_aux);
				}
			}
			else if((buttonClicked as Button) == boton_idioma_es)
			{
				trace(Game.saveGame.data["lang"]);
				Game.saveGame.setProperty("lang", Textos.ENGLISH);
				texto.text = Textos.LANG_CHANGE_ES;
				this.removeChild(boton_idioma_es)
				this.addChild(boton_idioma_en);
			}
			else if((buttonClicked as Button) == boton_idioma_en)
			{
				trace(Game.saveGame.data["lang"]);
				Game.saveGame.setProperty("lang", Textos.SPANISH);
				texto.text = Textos.LANG_CHANGE_EN;
				this.removeChild(boton_idioma_en)
				this.addChild(boton_idioma_es);
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