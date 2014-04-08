package 
{
	import flash.display.StageQuality;
	import flash.display.Sprite;
	import net.hires.debug.Stats;
	import otros.DatosNivel;
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="540", height="960", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		
		public function Main()
		{
			stats = new Stats();
			//this.addChild(stats);
			
			myStarling = new Starling(Home, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
			stage.quality = StageQuality.LOW;
		}
	}
}