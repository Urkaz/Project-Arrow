package utils 
{
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import events.NavigationEvent;
	
	public class BotonNivel extends Sprite 
	{
		private var bg:Image;
		private var victory:Image;
		private var stars:Image;
		private var level:int;
		private var scroll:Boolean = false;
		private var lvlType:String;
		private var victoryType:String;
		
		public function BotonNivel(lvlType:String, victoryType:String, level:int, score:int, starsCount:int, lock:Boolean = true)
		{
			this.level = level;
			this.lvlType = lvlType;
			this.victoryType = victoryType;
			
			if (lock)
			{
				bg = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Candado_"+lvlType));
				this.addChild(bg);
			}
			else
			{
				bg = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Nivel_" + lvlType));
				victory = new Image(Assets.getAtlas("levelSelectSprite").getTexture("Victoria_" + victoryType));
				stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount+"_Estrellas"));
				
				victory.x = this.x + 29;
				victory.y = this.y + 10;
				stars.x = this.x + 480;
				stars.y = this.y + 21;
				
				this.addChild(bg);
				this.addChild(victory);
				this.addChild(stars);
			}
			
			if(!lock)
				this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var moved:Touch = e.getTouch(this, TouchPhase.MOVED);
			var end:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (moved)
			{
				scroll = true;
			}
			if (end)
			{
				if(!scroll)
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: level, type: lvlType, vic: victoryType }, true));
				scroll = true;
			}
		}
		
	}

}