package objects 
{
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	import utils.Assets;
	import utils.Texts;
	import utils.WindowBase;
	
	public class WindowLevel extends WindowBase
	{
		private var descrip:TextField;
		
		private var stars:Image;
		private var closeBtn:Button;
		private var playBtn:Button;
		
		public function WindowLevel(numLvl:int, starsCount:int, type:String, victory:String, stage:Stage)
		{
			super(numLvl, starsCount, type, victory, stage);
			
			closeBtn = new Button(Assets.getAtlas("botones_"+Texts.LANG).getTexture("Boton_Atras"));
			playBtn = new Button(Assets.getAtlas("botones_"+Texts.LANG).getTexture("Boton_Start"));
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			descrip = new TextField(250, 100, "" , Assets.getFont("Textos").name, 30, 0xffffff);
			
			mainTxt.text = Texts.STATS_LEVEL + numLvl;
			
			if(victory == "time")
				descrip.text = Texts.STATS_TIME_DESCRIPTION;
			else if(victory == "lives")
				descrip.text = Texts.STATS_LIVES_DESCRIPTION;
			else if(victory == "combo")
				descrip.text = Texts.STATS_COMBO_DESCRIPTION;
			
			
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
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: numLvl, type: type, vic: victory }, true));
			}
			else if((buttonClicked as Button) == closeBtn)
			{
				closeOutWindowAnim();
			}
		}
	}

}
