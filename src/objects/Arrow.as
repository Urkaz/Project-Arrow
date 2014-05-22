package objects 
{
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import utils.Assets;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Arrow extends Sprite 
	{
		//CONSTANTES
		public static const TYPE_NORMAL:String = "normal";
		public static const TYPE_FIRE:String = "fire";
		public static const TYPE_PLANT:String = "plant";
		public static const TYPE_ELECTRIC:String = "elec";
		public static const TYPE_ICE:String = "ice";
		public static const TYPE_FAST:String = "fast";
		
		public static const STATUS_MOVING:String = "moving";
		public static const STATUS_DESTROY:String = "destroy";
		
		//Variables
		private var tipoFlecha:String;
		private var velocidad:Number;
		private var flecha:Image;
		private var particles:PDParticleSystem;
		private var status:String; //Cayendo, pendiente de destruir, en el suelo, sleecionada, etc...
		
		
		public function Arrow(tipoFlecha:String, visible:Boolean = true, velocidad:Number = 0)
		{
			this.tipoFlecha = tipoFlecha;
			this.velocidad = velocidad;
			
			status = STATUS_MOVING;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				if (status == STATUS_MOVING)
				{
					var localPos:Point = touch.getLocation(this);
					status = STATUS_DESTROY;
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
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createArrowArt();
		}
		
		private function createArrowArt():void
		{
			flecha = new Image(Assets.getAtlas("gameSprite").getTexture("Flecha"));
			
			if (tipoFlecha != TYPE_NORMAL)
			{
				particles = Assets.getParticleSystem("Particle_" + tipoFlecha);
				Starling.juggler.add(particles);
				particles.start();
				
				particles.x = flecha.width / 2;
				particles.y = flecha.height;
				
				this.addChild(particles);
			}
			
			//Cambiar si se cambia el ancho del escenario
			this.x = Math.floor(Math.random() * (stage.stageWidth*0.9 - stage.stageWidth*0.1 + 1)) + stage.stageWidth*0.1;
			this.y = -flecha.height;
			
			this.addChild(flecha);
		}
		
		public function destroy():void
		{
			if (tipoFlecha != TYPE_NORMAL)
			{
				Starling.juggler.remove(particles);
				particles.stop();
				
				this.removeChild(particles);
			}
			this.removeChild(flecha);
		}
	}
}