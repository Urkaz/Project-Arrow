package utils 
{
	public class Textos 
	{
		public static const SPANISH:String = "es";
		public static const ENGLISH:String = "en";
		
		public static var LANG:String;
		
		public static var FINAL_VICTORY:String;
		public static var FINAL_GAMEOVER:String;
		public static var FINAL_RESULTS:String;
		public static var FINAL_POINTS:String;
		public static var FINAL_TIME:String;
		public static var FINAL_LIVES:String;
		public static var FINAL_GAMEOVER_DESCRIP:String;
		
		public static var STATS_LEVEL:String;
		public static var STATS_TIME_DESCRIPTION:String;
		public static var STATS_LIVES_DESCRIPTION:String;
		public static var STATS_COMBO_DESCRIPTION:String;
		
		public static var PAUSE_MAIN:String;
		public static var PAUSE_DESCRIPTION:String;
		
		public function Textos()
		{
		}
		
		//Clase com la que se gestianarán los idiomas del juego
		static public function selectLang(lang:String):void
        {
			LANG = lang;
			
			if (lang == "en")
			{
				FINAL_VICTORY = "ViCtOrY";
				FINAL_GAMEOVER = "GaMe OvEr";
				FINAL_RESULTS = "Results";
				FINAL_POINTS = "Points:";
				FINAL_TIME = "Time:";
				FINAL_LIVES = "Lives:";
				FINAL_GAMEOVER_DESCRIP = "¡Game Over!";
				
				PAUSE_MAIN = "PaUsE";
				PAUSE_DESCRIPTION = "¡Game Paused!";
				
				STATS_LEVEL = "LeVeL ";
				STATS_TIME_DESCRIPTION = "STATS_TIME_DESCRIPTION";
				STATS_LIVES_DESCRIPTION = "STATS_LIVES_DESCRIPTION";
				STATS_COMBO_DESCRIPTION = "STATS_COMBO_DESCRIPTION";
			}
			else //español por defecto
			{
				FINAL_VICTORY = "ViCtOrIa";
				FINAL_GAMEOVER = "GaMe OvEr";
				FINAL_RESULTS = "Resultados";
				FINAL_POINTS = "Puntos:";
				FINAL_TIME = "Tiempo:";
				FINAL_LIVES = "Vidas:";
				FINAL_GAMEOVER_DESCRIP = "¡Fin del juego!";
				
				PAUSE_MAIN = "PaUsA";
				PAUSE_DESCRIPTION = "¡Juego en pausa!";
				
				STATS_LEVEL = "NiVeL ";
				STATS_TIME_DESCRIPTION = "¡Aguanta hasta que se acabe el tiempo!";
				STATS_LIVES_DESCRIPTION = "¡Acaba con tu enemigo en el menor tiempo posible!";
				STATS_COMBO_DESCRIPTION = "¡Realiza los combos en el menor tiempo posible!";
			}
        }
	}
}