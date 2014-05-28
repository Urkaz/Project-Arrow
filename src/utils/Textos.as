package utils 
{
	public class Textos 
	{
		//ESPAÑOL
		public static var FINAL_VICTORY:String;
		public static var FINAL_GAMEOVER:String;
		
		public static var STATS_LEVEL:String;
		public static var STATS_TIME_DESCRIPTION:String;
		public static var STATS_LIVES_DESCRIPTION:String;
		public static var STATS_COMBO_DESCRIPTION:String;
		
		public static var PAUSE_MAIN:String;
		public static var PAUSE_DESCRIPTION:String;
		
		public function Textos()
		{
		}
		
		static public function selectLang(lang:String):void
        {
			if (lang == "en")
			{
				FINAL_VICTORY = "ViCtOrY";
				FINAL_GAMEOVER = "GaMe OvEr";
				
				PAUSE_MAIN = "PaUsE";
				PAUSE_DESCRIPTION = "PAUSE_DESCRIPTION";
				
				STATS_LEVEL = "LeVeL ";
				STATS_TIME_DESCRIPTION = "STATS_TIME_DESCRIPTION";
				STATS_LIVES_DESCRIPTION = "STATS_LIVES_DESCRIPTION";
				STATS_COMBO_DESCRIPTION = "STATS_COMBO_DESCRIPTION";
			}
			else //español por defecto
			{
				FINAL_VICTORY = "ViCtOrIa";
				FINAL_GAMEOVER = "GaMe OvEr";
				
				PAUSE_MAIN = "PaUsA";
				PAUSE_DESCRIPTION = "¡Juego pausado!";
				
				STATS_LEVEL = "NiVeL ";
				STATS_TIME_DESCRIPTION = "¡Aguanta hasta que se acabe el tiempo!";
				STATS_LIVES_DESCRIPTION = "¡Acaba con tu enemigo en el menor tiempo posible!";
				STATS_COMBO_DESCRIPTION = "¡Realiza los combos en el menor tiempo posible!";
			}
        }
	}
}