package utils 
{
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
		
		private var closeBtn:Button;
		private var playBtn:Button;
		
		private var numLvl:int;
		private var type:String;
		private var victory:String;
		
		public function VentanaNiveles(numLvl:int, starsCount:int, type:String, victory:String) 
		{
			this.numLvl = numLvl;
			this.type = type;
			this.victory = victory;
			
			closeBtn = new Button(Assets.getTexture("Boton_Atras"));
			playBtn = new Button(Assets.getTexture("Boton_Start"));
			selector = new Image(Assets.getTexture("Selector"));
			
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount + "_Estrellas"));
			
			numeroNivel = new TextField(300, 220,"NiVeL " + String(numLvl) , Assets.getFont("Banderas").name, 85, 0xffffff);
			
			closeBtn.x = 150;
			closeBtn.y = 150;
			
			playBtn.x = 300;
			playBtn.y = 300;
			
			
			this.addChild(selector);
			this.addChild(numeroNivel)
			
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
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "lvlclose" }, true));
			}
		}
	}

}
