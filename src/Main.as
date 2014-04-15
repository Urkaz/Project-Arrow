package 
{
	import flash.desktop.NativeApplication;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import net.hires.debug.Stats;
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="320", height="480", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Codigo a partir de aqui
			stats = new Stats();
			this.addChild(stats);
			
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			 
			myStarling = new Starling(Game, stage, viewPort);
			myStarling.stage.stageWidth  = 320;
			myStarling.stage.stageHeight = 480;
			
			myStarling.antiAliasing = 1;
			myStarling.start();
			stage.quality = StageQuality.LOW;
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}