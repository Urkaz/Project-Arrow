package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Assets;
	
	public class Flecha extends Sprite 
	{
		
		private var _TipoFlecha:int;
		private var _Velocidad:int;
		private var _Distancia:int;
		private var _Visible:Boolean;
		private var _Choque:Boolean;
		private var _position:String;
		private var flecha:Image;
		
		
		public function Flecha(_TipoFlecha:int, _Distancia:int, _Visible:Boolean = true, _Velocidad:int = 0)
		{
			super();
			
			this._TipoFlecha = _TipoFlecha;
			this._Distancia = _Distancia;
			this._Visible = _Visible;
			this._Velocidad = _Velocidad;
			
			_Choque = false;
			//Already_hit
			
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

		public function get distance():int
		{
			return _Distancia;
		}

		public function set distance(value:int):void
		{
			_Distancia = value;
		}

		public function get position():String
		{
			return _position;
		}

		public function set position(value:String):void
		{
			_position = value;
		}

		public function get alreadyHit():Boolean
		{
			return _Choque;
		}

		public function set alreadyHit(value:Boolean):void
		{
			_Choque = value;
			/*
			if (value)
			{
				obstacleCrashImage.visible = true;
				if (_type == 4) obstacleAnimation.visible = false;
				else obstacleImage.visible = false;
			}
			*/
		}

		public function get watchOut():Boolean
		{
			return _Visible;
		}
		
		
		public function set watchOut(value:Boolean):void
		{
			_Visible = value;
			/*
			if (watchOutAnimation)
			{
				if (value) watchOutAnimation.visible = true;
				else watchOutAnimation.visible = false;
			}
			*/
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createObstacleArt();
			//createObstacleCrashArt();
			//createWatchOutAnimation();
		}
		/*
		private function createWatchOutAnimation():void
		{
			watchOutAnimation = new MovieClip(Assets.getAtlas().getTextures("watchOut_"), 10);
			Starling.juggler.add(watchOutAnimation);
			
			if (_type == 4)
			{
				watchOutAnimation.x = -watchOutAnimation.texture.width;
				watchOutAnimation.y = obstacleAnimation.y + (obstacleAnimation.texture.height * 0.5) - (watchOutAnimation.texture.height * 0.5);
			}
			else
			{
				watchOutAnimation.x = -watchOutAnimation.texture.width;
				watchOutAnimation.y = obstacleImage.y + (obstacleImage.texture.height * 0.5) - (watchOutAnimation.texture.height * 0.5);
			}
			this.addChild(watchOutAnimation);
		}
		
		private function createObstacleCrashArt():void
		{
			obstacleCrashImage = new Image(Assets.getAtlas().getTexture("obstacle" + _type + "_crash"));
			obstacleCrashImage.visible = false;
			this.addChild(obstacleCrashImage);
		}
		*/
		private function createObstacleArt():void
		{
			flecha = new Image(Assets.getTexture("Arrow"));
			//flecha.x = 0;
			//flecha.y = 0;
			this.addChild(flecha);
		}
		
	}

}