package objects 
{
	import starling.display.Button;
	import starling.display.Stage;
	import starling.text.TextField;
	import utils.Assets;
	import utils.Textos;
	import utils.VentanaBase;
	import starling.events.Event;
	import events.NavigationEvent;
	
	public class VentanaPausa extends VentanaBase
	{
		private var descrip:TextField;
		
		private var replayBtn:Button;
		private var menuBtn:Button;
		private var contBtn:Button;
		
		public function VentanaPausa(numLvl:int, starsCount:int, type:String, victoryType:String, stage:Stage)
		{
			super(numLvl, starsCount, type, victoryType, stage);
			
			replayBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_repetir"));
			menuBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_menu"));
			contBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Continuar"));
			
			descrip = new TextField(250, 100, Textos.PAUSE_DESCRIPTION , Assets.getFont("Textos").name, 30, 0xffffff);
			
			mainTxt.text = Textos.PAUSE_MAIN;
			
			replayBtn.x = contBtn.x = menuBtn.x = selector.x + selector.width / 2 - replayBtn.width / 2;
			
			replayBtn.x -= 110;
			menuBtn.x += 110;
			
			replayBtn.y = menuBtn.y = contBtn.y = selector.y + selector.height - replayBtn.height - 12;
			
			descrip.x = selector.x + selector.width / 2 - descrip.width / 2;
			descrip.y = selector.y + selector.height / 2 - descrip.height / 2;
			
			this.addChild(descrip);
			this.addChild(replayBtn);
			this.addChild(menuBtn);
			this.addChild(contBtn);
			
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
			else if((buttonClicked as Button) == contBtn)
			{
				//closeOutWindowAnim();
				this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "close", pause: true }, true));
			}
		}
	}
}