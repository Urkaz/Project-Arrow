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
		
		private var DEBUG:Boolean = false; //ELIMINAR DE LA VERSIÓN FINAL JUNTO A TODO SU CODIGO
		 
		private var numeroNivel:int = 0;
		private var tiempo:int = 0; //Tiempo que hay que tardar
		private var muertesMin:int = 0;
		private var spawnMin:Number = 0;
		private var spawnMax:Number = 0;
		
		private var arrayFlechas:Array = new Array(); //Array de String tipo
		private var arrayFlechasProb:Array = new Array(); //Array de int
		private var arrayFlechasVel:Array = new Array(); //Array de Number
		
		private var waterPanel:Boolean = false;
		private var fogPanel:Boolean = false;
		private var nightPanel:Boolean = false;
		private var grassPanel:int = 0;
		
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
		public function get Nivel():int
		{
			return numeroNivel;
		}
		
		public function get MuertesMin():int
		{
			return muertesMin;
		}
		
		public function get TimeSpawnMin():int
		{
			return spawnMin*1000;
		}
		
		public function get TimeSpawnMax():int
		{
			return spawnMax*1000;
		}
			
		public function get Flechas():Array
		{
			return new Array(arrayFlechas, arrayFlechasProb, arrayFlechasVel);
		}
			
		public function get Victoria():Array
		{
			return arrayVictoria;
		}
			
		public function get Soldados():Array
		{
			return arraySoldados;
		}
		
		public function get isWaterPanel():Boolean
		{
			return waterPanel;
		}
		
		public function get isFogPanel():Boolean
		{
			return fogPanel;
		}
		
		public function get isNightPanel():Boolean
		{
			return nightPanel;
		}
		
		public function get isGrassPanel():Boolean
		{
			if (grassPanel == 0)
				return false;
			else
				return true;
		}
		
		public function get countGrass():int
		{
			return grassPanel;
		}
		
		/*******************
		 * Funciones
		 *******************/
		
		/*
		 * Esta función hará que se lea y se cargue un XML u otro.
		 * Según se vayan añadiendo niveles, esta será la función dónde "registrarlos".
		 */
		public function loadLevel(level:int):void
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
					//return new XML(new Assets.nivel2());
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
			numeroNivel = xmlLevel.caract.attribute("nivel");
			tiempo = xmlLevel.caract.attribute("tiempo");
			muertesMin = xmlLevel.caract.attribute("muertes");
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
			waterPanel = (xmlLevel.panel.(@type == "water").status == "true");
			fogPanel = (xmlLevel.panel.(@type == "fog").status == "true");
			nightPanel = (xmlLevel.panel.(@type == "night").status == "true");
			grassPanel = int(xmlLevel.panel.(@type == "grass").status);
			
			//Leer condiciones de victoria
			attr = xmlLevel.victory.attributes();
			for (var v:int = 0; v < attr.length(); v = v+2)
			{
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
			
			//DEBUG
			if (DEBUG)
			{
				trace("----NIVEL----")
				trace("PROPIEDADES");
				trace("\t numeroNivel: " + numeroNivel);
				trace("\t muertesMin: " + muertesMin);
				
				trace("FLECHAS DEL NIVEL");
				for (var i:int = 0; i < arrayFlechas.length; i++)
				{
					trace("\t "+arrayFlechas[i]+" - P:"+arrayFlechasProb[i]+"% - V:"+arrayFlechasVel[i]);
				}
				
				trace("PANEL");
				trace("\t waterPanel: " + waterPanel);
				trace("\t fogPanel: " + fogPanel);
				trace("\t nightPanel: " + nightPanel);
				trace("\t grassPanel: " + grassPanel);
				
				trace("VICTORIA");
				for (var i1:int = 0; i1 < arrayVictoria.length; i1++)
				{
					trace("\t t:"+arrayVictoria[i1][0] + ", c:" + arrayVictoria[i1][1]);
				}
				
				trace("SOLDADOS");
				for (var i2:int = 0; i2 < arraySoldados.length; i2++)
				{
					trace("\t x:"+arraySoldados[i2][0] + ", y:" + arraySoldados[i2][1] + ", a:" + arraySoldados[i2][2] + ", p:" + arraySoldados[i2][3]);
				}
			}
		}
	}
}