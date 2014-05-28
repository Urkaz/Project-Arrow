package objects 
{
	import starling.display.Sprite;
	import utils.Textos;
	import utils.VentanaBase;
	
	public class VentanaPausa extends VentanaBase
	{
		
		public function VentanaPausa() 
		{
			mainTxt.text = Textos.PAUSE_MAIN;
		}
	}
}