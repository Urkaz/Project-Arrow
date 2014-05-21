package utils 
{
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	
	public class VentanaNiveles extends Sprite 
	{
		
		private var numeroNivel:TextField;

		private var selector:Image;
		private var stars:Image;
		private var negro:Image;
		
		private var closeBtn:Button;
		private var playBtn:Button;
		
		private var numLvl:int;
		private var type:String;
		private var victory:String;
		
		public function VentanaNiveles(numLvl:int, starsCount:int, type:String, victory:String, stage:Stage)
		{
			this.numLvl = numLvl;
			this.type = type;
			this.victory = victory;
			
			negro = new Image(Assets.getAtlas("levelSelectSprite").getTexture("negro"));
			
			closeBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Atras"));
			playBtn = new Button(Assets.getAtlas("levelSelectSprite").getTexture("Boton_Start"));
			selector = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Selector_" + type));
			
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			numeroNivel = new TextField(250, 100,"NiVeL " + String(numLvl) , Assets.getFont("Banderas").name, 60, 0xffffff);
			
			//Posiciones
			selector.x = stage.stageWidth / 2 - selector.width / 2;
			selector.y = stage.stageHeight / 2 - selector.height / 2;
			
			closeBtn.x = playBtn.x = selector.x + selector.width / 2 - closeBtn.width / 2;
			closeBtn.x -= 100;
			playBtn.x += 100;
			closeBtn.y = playBtn.y = selector.y + selector.height - closeBtn.height - 12;
			
			numeroNivel.x = selector.x + selector.width / 2 - numeroNivel.width / 2;
			numeroNivel.y = selector.y + 40;
			
			negro.width = stage.stageWidth;
			negro.height = stage.stageHeight;
			negro.alpha = 0.5;
			
			this.addChild(negro);
			
			this.addChild(selector);
			this.addChild(numeroNivel)
			
			this.addChild(closeBtn);
			this.addChild(playBtn);
			//this.addChild(stars);
			
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
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "lvlclose" }, true));
			}
		}
	}

}
