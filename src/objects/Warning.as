package objects
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Assets;

	public class Warning extends Sprite
	{
		private var img:Image;
		private var tween:Tween;
		
		public function Warning()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createArt();
		}
		
		private function createArt():void
		{
			img = new Image(Assets.getAtlas("gameSprite").getTexture("peligro"));
			
			tween = new Tween(this, 0.5);
			tween.animate("scaleX", 0.7);
			tween.animate("scaleY", 0.7);
			tween.repeatCount = 0;
			tween.reverse = true;
			
			Starling.juggler.add(tween);
			
			this.addChild(img);
		}
		
		public function destroy():void
		{
			Starling.juggler.remove(tween);
		}
	}
}