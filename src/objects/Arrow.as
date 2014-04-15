package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Assets;
	
	public class Arrow extends Sprite 
	{
		private var tipoFlecha:String;
		private var velocidad:Number;
		private var _visible:Boolean;
		private var choque:Boolean;
		private var flecha:Image;
		
		public function Arrow(tipoFlecha:String, visible:Boolean = true, velocidad:Number = 0)
		{
			this.tipoFlecha = tipoFlecha;
			this._visible = visible;
			this.velocidad = velocidad;
			
			choque = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function get Velocidad():Number
		{
			return velocidad;
		}
		
		public function set Velocidad(value:Number):void
		{
			velocidad = value;
		}
		
		public function get alreadyHit():Boolean
		{
			return choque;
		}
		
		public function set alreadyHit(value:Boolean):void
		{
			choque = value;
		}

		public function get watchOut():Boolean
		{
			return _visible;
		}
		
		public function set watchOut(value:Boolean):void
		{
			_visible = value;
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createObstacleArt();

		}
		private function createObstacleArt():void
		{
			flecha = new Image(Assets.getTexture("Arrow"));
			
			//Hacer random
			flecha.x = 200;
			flecha.y = 200;
			
			this.addChild(flecha);
		}
		
	}
}