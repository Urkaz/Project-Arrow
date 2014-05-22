package utils 
{
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	
	public class VentanaNiveles extends Ventana
	{
		private var descrip:TextField;
		
		private var stars:Image;
		private var closeBtn:Button;
		private var playBtn:Button;
		
		public function VentanaNiveles(numLvl:int, starsCount:int, type:String, victory:String, stage:Stage)
		{
			super(numLvl, starsCount, type, victory, stage);
			
			closeBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Atras"));
			playBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Start"));
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			descrip = new TextField(250, 100, "Descripcion" , Assets.getFont("Banderas").name, 30, 0xffffff);
			
			mainTxt.text = "NiVeL " + numLvl;
			
			if(victory == "time")
				descrip.text = "¡Aguanta hasta que se acabe el tiempo! (Puntuacion, Vidas)";
			else if(victory == "lives")
				descrip.text = "¡Acaba con tu enemigo bajandole vida en el menor tiempo posible! (Puntuacion, Vidas)";
			else if(victory == "combo")
				descrip.text = "¡Realiza los combos en el menor tiempo posible! (Puntuacion, Vidas)";
			
			
			//Posiciones
			
			closeBtn.x = playBtn.x = selector.x + selector.width / 2 - closeBtn.width / 2;
			closeBtn.x -= 100;
			playBtn.x += 100;
			closeBtn.y = playBtn.y = selector.y + selector.height - closeBtn.height - 12;
			
			stars.x = selector.x + selector.width / 2 - stars.width / 2;
			stars.y = mainTxt.y + mainTxt.height - 20;
			
			descrip.x = selector.x + selector.width / 2 - descrip.width / 2;
			descrip.y = stars.y + stars.height + 20;

			this.addChild(descrip);
			this.addChild(closeBtn);
			this.addChild(playBtn);
			this.addChild(stars);
			
			this.addEventListener(Event.TRIGGERED, buttonClick);
		}
		
		private function buttonClick(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;
			if((buttonClicked as Button) == playBtn)
			{
				//closeInWindowAnim();
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: numLvl, type: type, vic: victory }, true));
			}
			else if((buttonClicked as Button) == closeBtn)
			{
				closeOutWindowAnim();
			}
		}
	}

}
