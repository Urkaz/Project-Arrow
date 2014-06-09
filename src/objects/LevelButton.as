package objects 
{
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import events.NavigationEvent;
	
	public class LevelButton extends Sprite 
	{
		private var bg:Image;
		private var victory:Image;
		private var stars:Image;
		private var level:int;
		private var scroll:Boolean = false;
		private var lvlType:String;
		private var victoryType:String;
		private var numNivel:TextField;
		private var starsCount:int;
		
		public function LevelButton(lvlType:String, victoryType:String, level:int, starsCount:int)
		{
			this.level = level;
			this.lvlType = lvlType;
			this.victoryType = victoryType;
			this.starsCount = starsCount;
			
			Lock();
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var moved:Touch = e.getTouch(this, TouchPhase.MOVED);
			var end:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (moved)
			{
				scroll = true;
			}
			else if (end)
			{
				if(!scroll)
					this.dispatchEvent(new NavigationEvent(NavigationEvent.POPUP_WINDOW, { id: "lvlstats", lvl: level, stars: starsCount, type: lvlType, vic: victoryType }, true));
				scroll = false;
			}
		}
		
		public function Unlock():void
		{
			bg = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Nivel_" + lvlType));
			victory = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Victoria_" + victoryType));
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
			
			victory.x = 10;
			victory.y = bg.height / 2 - victory.height / 2 - 10;
			stars.x = bg.width - stars.width - 10;
			stars.y = bg.height / 2 - stars.height / 2 - 10;
			
			numNivel = new TextField(200, bg.height-10, String(level+1), Assets.getFont("FontLevel").name, 40, 0xffffff);
			numNivel.x = bg.width / 2 - numNivel.width / 2;
			numNivel.y = bg.height / 2 - numNivel.height / 2;
			
			this.addChild(bg);
			this.addChild(victory);
			this.addChild(stars);
			this.addChild(numNivel);
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function Lock():void
		{
			this.removeChild(bg);
			this.removeChild(victory);
			this.removeChild(stars);
			this.removeChild(numNivel);
			
			victory = stars = null;
			numNivel = null;
			
			bg = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Candado_" + lvlType));
			this.addChild(bg);
			
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function Update(starsCount:int):void
		{
			stars.texture = Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas");
		}
	}
}