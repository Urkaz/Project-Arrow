package utils 
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	import events.NavigationEvent;
	
	public class Ventana extends Sprite 
	{
		protected var mainTxt:TextField;
		
		protected var selector:Image;
		protected var negro:Image;
		
		protected var numLvl:int;
		protected var type:String;
		protected var victory:String;
		
		private var tween:Tween;
		
		public function Ventana(numLvl:int, starsCount:int, type:String, victory:String, stage:Stage)
		{
			this.numLvl = numLvl;
			this.type = type;
			this.victory = victory;
			
			selector = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Selector_" + type));
			negro = new Image(Assets.getAtlas("levelSelectSprite").getTexture("negro"));
			
			mainTxt = new TextField(250, 100, "TeXtO" , Assets.getFont("Banderas").name, 60, 0xffffff);
			
			//Posiciones
			selector.x = stage.stageWidth / 2 - selector.width / 2;
			selector.y = stage.stageHeight / 2 - selector.height / 2;
			
			mainTxt.x = selector.x + selector.width / 2 - mainTxt.width / 2;
			mainTxt.y = selector.y + 40;
			
			negro.width = stage.stageWidth;
			negro.height = stage.stageHeight;
			negro.alpha = 0.5;
			
			this.addChild(negro);
			
			this.addChild(selector);
			this.addChild(mainTxt);
			
			openWindowAnim();
		}
		
		public function openWindowAnim():void
		{
			//Animacion
			this.alpha = 0;
			tween = new Tween(this, 0.15);
			tween.animate("alpha", 1);
			Starling.juggler.add(tween);
					
			//Al completar la animacion
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
			};
		}
		
		public function closeOutWindowAnim():void 
		{
			//Animacion
			tween = new Tween(this, 0.15);
			tween.animate("alpha", 0);
			Starling.juggler.add(tween);
			//Al completar la animacion borrar
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
				dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "close", cs: false}, true));
			};
		}
		
		public function closeInWindowAnim():void 
		{
			//Animacion		
			tween = new Tween(negro, 0.15);
			tween.animate("alpha", 1);
			Starling.juggler.add(tween);
			//Al completar la animacion borrar
			tween.onComplete = function():void
			{
				Starling.juggler.remove(tween);
				//dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "close" }, true));
			};
		}
	}
}
