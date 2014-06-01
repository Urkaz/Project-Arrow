package utils 
{
	import flash.geom.Point;
	
	/**
	 * Esta clase cargará el XML del nivel y almacenará todos sus datos.
	 * Mediante funciones se leerán desde otros sitios estos datos.
	 */
	public class DatosNivel 
	{
		/*******************
		 * Atributos
		 *******************/
		
		private var tiempo:int = 0;
		private var puntos:int = 0;
		private var vidas:int = 0;
		private var salud:int = 0;
		private var spawnMin:Number = 0;
		private var spawnMax:Number = 0;
		
		private var arrayFlechas:Array = new Array(); //Array de String tipo
		private var arrayFlechasProb:Array = new Array(); //Array de int
		private var arrayFlechasVel:Array = new Array(); //Array de Number
		
		private var fogPanel:Boolean = false;
		
		private var arrayVictoria:Array = new Array(); //Array de Array(String tipo_flecha, int cantidad)
		
		private var arraySoldados:Array = new Array(); //Array de Array(int x,int y,int armadura,int ancho_plataforma)
		
		/*******************
		 * Constructor
		 *******************/
		public function DatosNivel(level:int = 0)
		{
			loadLevel(level);
		}
		
		/*******************
		 * GETTERS
		 *******************/
		public function get Vidas():int
		{
			return vidas;
		}
		
		public function get TiempoVictoria():int
		{
			return tiempo;
		}
		
		public function get PuntosVictoria():int
		{
			return puntos;
		}
		
		public function get SaludVictoria():int
		{
			return salud;
		}
		
		public function get TimeSpawnMin():Number
		{
			return spawnMin;
		}
		
		public function get TimeSpawnMax():Number
		{
			return spawnMax;
		}
			
		public function get Flechas():Array
		{
			return new Array(arrayFlechas, arrayFlechasProb, arrayFlechasVel);
		}
			
		public function get CombosVictoria():Array
		{
			return arrayVictoria;
		}
			
		public function get Soldados():Array
		{
			return arraySoldados;
		}
		
		public function get isFogPanel():Boolean
		{
			return fogPanel;
		}
		
		/*******************
		 * Funciones
		 *******************/
		
		/*
		 * Esta función hará que se lea y se cargue un XML u otro.
		 * Según se vayan añadiendo niveles, esta será la función dónde "registrarlos".
		 */
		private function loadLevel(level:int):void
		{
			switch(level)
			{
				case 0:
					readXML(new XML(new Assets.nivel0()));
					break;
				case 1:
					readXML(new XML(new Assets.nivel1()));
					break;
				case 2:
					readXML(new XML(new Assets.nivel2()));
					break;
			}
		}
		 
		/*
		 * Esta función se encarga de leer el XML que se le pase como parámetro.
		 * Es una clase privada que funciona en conjunto con loadLevel y guarda todos los datos del XML en distintos atributos de la clase.
		 */
		private function readXML(xmlLevel:XML):void
		{
			var attr:XMLList;
			
			//Leer las propiedades del nivel
			tiempo = xmlLevel.caract.attribute("tiempo");
			puntos = xmlLevel.caract.attribute("puntos");
			vidas = xmlLevel.caract.attribute("vidas");
			salud = xmlLevel.caract.attribute("health");
			spawnMin = Number(xmlLevel.caract.attribute("spawnMin"));
			spawnMax = Number(xmlLevel.caract.attribute("spawnMax"));
			
			//Leer las flechas que tendrá el nivel
			attr = xmlLevel.arrow.attributes();
			for each (var tipo:XML in attr)
			{
				if(tipo.name() == "type")
					arrayFlechas.push(tipo);
				else if(tipo.name() == "prob")
					arrayFlechasProb.push(int(tipo));
				else if(tipo.name() == "vel")
					arrayFlechasVel.push(Number(tipo));
			}
			
			//Comprobar si la probabilidad es correcta
			var maxProb:int;
			for each(var fp:int in arrayFlechasProb)
				maxProb += fp;
			if (maxProb != 100)
				throw new Error("La suma de probabilidades de las flechas debe ser 100");
			
			//Leer las propiedades del panel
			fogPanel = (xmlLevel.panel.(@type == "fog").status == "true");
			
			//Leer condiciones de victoria
			attr = xmlLevel.victory.attributes();
			for (var v:int = 0; v < attr.length(); v = v+2)
			{
				//tipo, num
				var condicion:Array = new Array(attr[v], int(attr[v + 1]));
				arrayVictoria.push(condicion);
			}
			
			//Leer los soldados
			attr = xmlLevel.soldier.attributes();
			for (var s:int = 0; s < attr.length(); s = s+4)
			{
				var soldado:Array = new Array(attr[s], attr[s + 1], attr[s + 2], attr[s + 3]);
				arraySoldados.push(soldado);
			}
		}
	}
}