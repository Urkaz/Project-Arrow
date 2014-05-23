package objects 
{
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	import utils.Assets;
	import utils.Textos;
	import utils.VentanaBase;
	
	public class VentanaFinal extends VentanaBase
	{
		private var descrip:TextField;
		
		private var stars:Image;
		private var replayBtn:Button;
		private var menuBtn:Button;
		
		public function VentanaFinal(numLvl:int, starsCount:int, type:String, victoryType:String, stage:Stage, gameOver:Boolean)
		{
			super(numLvl, starsCount, type, victoryType, stage);
			
			replayBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_repetir"));
			menuBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_menu"));
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			descrip = new TextField(250, 100, "Descripcion" , Assets.getFont("Textos").name, 30, 0xffffff);
			
			if(!gameOver)
				mainTxt.text = Textos.FINAL_VICTORY;
			else
				mainTxt.text = Textos.FINAL_GAMEOVER;
			
			/* si modo tiempo
			 * 		no mostrar reloj
			 * 		mostrar puntos
			 * 		mostrar vidas
			 *
			 * si modo vidas
			 * 		mostrar reloj
			 * 		no mostrar vidas
			 * 		mostrar puntos
			 *
			 */
				
			
			
			//Posiciones
			
			replayBtn.x = menuBtn.x = selector.x + selector.width / 2 - replayBtn.width / 2;
			replayBtn.x -= 100;
			menuBtn.x += 100;
			replayBtn.y = menuBtn.y = selector.y + selector.height - replayBtn.height - 12;
			
			stars.x = selector.x + selector.width / 2 - stars.width / 2;
			stars.y = mainTxt.y + mainTxt.height - 20;
			
			descrip.x = selector.x + selector.width / 2 - descrip.width / 2;
			descrip.y = stars.y + stars.height + 20;
			
			this.addChild(descrip);
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
