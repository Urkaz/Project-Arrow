package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import utils.Assets;
	import events.NavigationEvent;
	import utils.Texts;
	
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
			
			boton_playHome = new Button(Assets.getAtlas("botones_"+Texts.LANG).getTexture("PlayInicial"));
			boton_borrarPartida = new Button(Assets.getAtlas("botones_"+Texts.LANG).getTexture("borrar"));
			boton_instrucciones = new Button(Assets.getAtlas("botones_" + Texts.LANG).getTexture("Instr"));
			
			boton_idioma_en = new Button(Assets.getAtlas("botones_" + Texts.LANG).getTexture("lang_" + Texts.ENGLISH));
			boton_idioma_es = new Button(Assets.getAtlas("botones_" + Texts.LANG).getTexture("lang_" + Texts.SPANISH));
			
			texto = new TextField(boton_idioma_es.width, 100, "" , Assets.getFont("Textos").name, 20, 0xffffff);
			
			if(Texts.LANG == Texts.SPANISH)
				this.addChild(boton_idioma_en);
			else if(Texts.LANG == Texts.ENGLISH)
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
				
				if (Game.saveGame.data[0 + "_lock"] == undefined)
				{
					Game.saveGame.setProperty(0 + "_lock", false);
					Game.saveGame.setProperty(0 + "_stars", 0);
					Game.saveGame.setProperty("lang", lang_aux);
				}
			}
			else if((buttonClicked as Button) == boton_idioma_es)
			{
				Game.saveGame.setProperty("lang", Texts.SPANISH);
				texto.text = Texts.LANG_CHANGE_ES;
				this.removeChild(boton_idioma_es)
				this.addChild(boton_idioma_en);
			}
			else if((buttonClicked as Button) == boton_idioma_en)
			{
				Game.saveGame.setProperty("lang", Texts.ENGLISH);
				texto.text = Texts.LANG_CHANGE_EN;
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