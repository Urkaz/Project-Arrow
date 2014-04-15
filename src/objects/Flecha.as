package objects 
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Assets;
	
	public class Flecha extends Sprite 
	{
		private var _TipoFlecha:int;
		private var _Velocidad:int;
		private var _Visible:Boolean;
		private var _Choque:Boolean;
		private var flecha:Image;
		
		public function Flecha(tipoFlecha:int, visible:Boolean = true, velocidad:int = 0)
		{
			this._TipoFlecha = tipoFlecha;
			this._Visible = visible;
			this._Velocidad = velocidad;
			
			_Choque = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function get Velocidad():int
		{
			return _Velocidad;
		}
		
		public function set Velocidad(value:int):void
		{
			_Velocidad = value;
		}
		
		public function get alreadyHit():Boolean
		{
			return _Choque;
		}
		
		public function set alreadyHit(value:Boolean):void
		{
			_Choque = value;
		}

		public function get watchOut():Boolean
		{
			return _Visible;
		}
		
		public function set watchOut(value:Boolean):void
		{
			_Visible = value;
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createObstacleArt();

		}
		private function createObstacleArt():void
		{
			var scale:Number = Starling.contentScaleFactor;
			
			flecha = new Image(Assets.getTexture("Arrow", scale));
			//flecha.x = 0;
			//flecha.y = 0;
			this.addChild(flecha);
		}
		
	}
}