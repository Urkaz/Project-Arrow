package 
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.display.Sprite;
	import net.hires.debug.Stats;
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="360", height="640", backgroundColor="0x333333")]
	//[SWF(frameRate="60", width="540", height="960", backgroundColor="0x333333")]
	//[SWF(frameRate="60", width="1080", height="1920", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.align = StageAlign.TOP_LEFT;
			
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
			stage.quality = StageQuality.HIGH;
		}
	}
}