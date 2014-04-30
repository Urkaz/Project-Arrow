package utils 
{
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.display.Image;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import events.NavigationEvent;
	
	public class BotonNivel extends Sprite 
	{
		//private var img:MovieClip;
		private var imagen:Image;
		private var level:int;
		
		public function BotonNivel(level:int) 
		{
			this.level = level;
			imagen = new Image(Assets.getTexture("candado750"));
			
			this.addChild(imagen);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				trace("sasfdasf");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "level", lvl: level}, true));
			}
		}
		
	}

}