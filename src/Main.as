package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import net.hires.debug.Stats;
	import otros.DatosNivel;
	import starling.core.Starling;
	
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
			
			myStarling = new Starling(Home, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
			
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}