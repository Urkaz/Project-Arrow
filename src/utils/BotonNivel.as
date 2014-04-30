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
		private var type:Image;
		private var stars:Image;
		private var level:int;
		private var scroll:Boolean = false;
		
		public function BotonNivel(level:int, score:int, starsCount:int, lock:Boolean = true) 
		{
			this.level = level;

			if (lock)
			{
				bg = new Image(Assets.getAtlas("levelSelectSprite").getTexture("nv_candado"));
				this.addChild(bg);
			}
			else
			{
				bg = new Image(Assets.getAtlas("levelSelectSprite").getTexture("nv_nieve"));
				stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture("estrellas_" + starsCount));
				
				this.addChild(bg);
				this.addChild(stars);
			}
			
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
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id: "level", lvl: level }, true));
				scroll = true;
			}
		}
		
	}

}