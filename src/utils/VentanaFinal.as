package utils 
{
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	
	public class VentanaFinal extends Ventana
	{
		private var descrip:TextField;
		
		private var stars:Image;
		private var replayBtn:Button;
		private var menuBtn:Button;
		
		public function VentanaFinal(numLvl:int, starsCount:int, type:String, victory:String, stage:Stage, status:int)
		{
			super(numLvl, starsCount, type, victory, stage);
			
			replayBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Atras"));
			menuBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Start"));
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			/* STATUS 1
			 * Victoria por tiempo: No se muestra reloj
			 * 
			 * STATUS 2
			 * Derrota por vidas perdidas
			 * 		si es nivel de victoria "time", el texto será "tiempo restante", si no "tiempo".
			 */
			
			descrip = new TextField(250, 100, "Descripcion" , Assets.getFont("Banderas").name, 30, 0xffffff);
			
			mainTxt.text = "NiVeL " + numLvl;
			

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
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "close" }, true));
				
				//this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: numLvl, type: type, vic: victory }, true));
			}
			else if((buttonClicked as Button) == replayBtn)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: numLvl, type: type, vic: victory }, true));
			}
		}
	}

}
