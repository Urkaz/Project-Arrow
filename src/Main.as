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
	import starling.utils.ScaleMode;
	import starling.utils.RectangleUtil;
	
	[SWF(frameRate="60", width="360", height="640", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Codigo a partir de aqui
			stats = new Stats();
			this.addChild(stats);
			
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.SHOW_ALL);
			 
			myStarling = new Starling(Game, stage, viewPort);
			myStarling.stage.stageWidth  = 360;
			myStarling.stage.stageHeight = 640;
			
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