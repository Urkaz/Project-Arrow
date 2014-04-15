package objects 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Arrow extends Sprite 
	{
		//CONSTANTES
		public static var MOVING:String = "moving";
		public static var DESTROY:String = "destroy";
		
		private var tipoFlecha:String;
		private var velocidad:Number;
		private var _visible:Boolean;
		private var choque:Boolean;
		private var flecha:Image;
		private var status:String; //Cayendo, pendiente de destruir, en el suelo, sleecionada, etc...
		
		public function Arrow(tipoFlecha:String, visible:Boolean = true, velocidad:Number = 0)
		{
			this.tipoFlecha = tipoFlecha;
			this._visible = visible;
			this.velocidad = velocidad;
			
			status = MOVING;
			
			choque = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				if (status == MOVING)
				{
					var localPos:Point = touch.getLocation(this);
					status = DESTROY;
				}
			}
		}
		
		public function get Status():String
		{
			return status;
		}
		
		public function get Velocidad():Number
		{
			return velocidad;
		}
		
		public function get Tipo():String
		{
			return tipoFlecha;
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
			flecha.x = Math.floor(Math.random() * (1080 - 0 + 1)) + 0;
			trace(flecha.x);
			flecha.y = -flecha.height;
			
			this.addChild(flecha);
		}
	}
}