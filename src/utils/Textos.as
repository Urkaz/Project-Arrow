package utils 
{
	public class Textos 
	{
		//ESPAÑOL
		public static var FINAL_VICTORY:String;
		public static var FINAL_GAMEOVER:String;
		
		public static var STATS_LEVEL:String;
		public static var STATS_TIME_DSECRIPTION:String;
		public static var STATS_LIVES_DSECRIPTION:String;
		public static var STATS_COMBO_DSECRIPTION:String;
		
		public function Textos()
		{
		}
		
		static public function selectLang(lang:String):void
        {
			if (lang == "en")
			{
				FINAL_VICTORY = "ViCtOrY";
				FINAL_GAMEOVER = "GaMe OvEr";
				
				STATS_LEVEL = "LeVeL ";
				STATS_TIME_DSECRIPTION = "STATS_TIME_DSECRIPTION";
				STATS_LIVES_DSECRIPTION = "STATS_LIVES_DSECRIPTION";
				STATS_COMBO_DSECRIPTION = "STATS_COMBO_DSECRIPTION";
			}
			else //español por defecto
			{
				FINAL_VICTORY = "ViCtOrIa";
				FINAL_GAMEOVER = "GaMe OvEr";
				
				STATS_LEVEL = "NiVeL ";
				STATS_TIME_DSECRIPTION = "¡Aguanta hasta que se acabe el tiempo!";
				STATS_LIVES_DSECRIPTION = "¡Acaba con tu enemigo en el menor tiempo posible!";
				STATS_COMBO_DSECRIPTION = "¡Realiza los combos en el menor tiempo posible!";
			}
        }
	}
}