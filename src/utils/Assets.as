package utils 
{

	//import air.update.core.UpdaterConfiguration;
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
	import starling.extensions.PDParticleSystem;
	//import starling.extensions.PDParticleSystem;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import starling.text.TextField;
	
	public class Assets 
	{
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		//Añadir imágenes
		//[Embed(source="")]
		//public static const (nombre):Class;
		
	
		// NIVELES //
		[Embed(source="../../assets/levels/TestLevel.xml", mimeType="application/octet-stream")]
		public static const nivel0:Class;
		
		[Embed(source="../../assets/levels/TestLevel.xml", mimeType="application/octet-stream")]
		public static const nivel1:Class;
		
		[Embed(source="../../assets/levels/LevelList.xml", mimeType="application/octet-stream")]
		public static const levelList:Class;
		
		// FUENTES //
		[Embed(source="../../assets/fonts/font.png")]
		public static const FontLevel:Class;
		
		[Embed(source="../../assets/fonts/font.fnt", mimeType="application/octet-stream")]
		public static const FontXML:Class;
		
		[Embed(source="../../assets/fonts/banderas.png")]
		public static const Banderas:Class;
		
		[Embed(source="../../assets/fonts/banderas.fnt", mimeType="application/octet-stream")]
		public static const BanderasXML:Class;
		
		// IMAGENES //
		[Embed(source="../../assets/images/levelSelection.xml", mimeType="application/octet-stream")]
		public static const levelSelectXML:Class;
		
		[Embed(source="../../assets/images/levelSelection.png")]
		public static const levelSelectSprite:Class;
		
		[Embed(source="../../assets/images/titulo_welcome.png")]
		public static const TituloWelcome:Class;
		
		[Embed(source="../../assets/images/arrow.png")]
		public static const Arrow:Class;
		
		[Embed(source="../../assets/images/Welcome_boton.png")]
		public static const BotonWelcome:Class;
		
		[Embed(source="../../assets/images/Fondo_Normal.png")]
		public static const Muralla_normal:Class;
		
		[Embed(source="../../assets/images/Fondo_Nieve.png")]
		public static const Muralla_snow:Class;
		
		[Embed(source="../../assets/images/Fondo_Tierra.png")]
		public static const Muralla_ground:Class;
		
		[Embed(source = "../../assets/images/Tablon_izq.png")]
		public static const Tablon_izq:Class;
		
		[Embed(source = "../../assets/images/Tablon_der.png")]
		public static const Tablon_der:Class;
		
		[Embed(source = "../../assets/images/Tablon_medio.png")]
		public static const Tablon_medio:Class;
		
		[Embed(source = "../../assets/images/soldado_1.png")]
		public static const Soldado_1:Class;
		
		[Embed(source = "../../assets/images/soldado_2.png")]
		public static const Soldado_2:Class;
		
		[Embed(source = "../../assets/images/soldado_3.png")]
		public static const Soldado_3:Class;
		
		//[Embed(source = "../../assets/images/Boton_Atras_Mitad.png")]
		//public static const Boton_Atras:Class;
		
		//[Embed(source = "../../assets/images/Boton_Start_Mitad.png")]
		//public static const Boton_Start:Class;
		
		
		[Embed(source="../../assets/particles/texture_fuego.png")]
		public static const Particle_Fuego:Class;
		
		[Embed(source="../../assets/particles/particle_fuego.pex", mimeType="application/octet-stream")]
		public static const particle_fuegoXML:Class;
		
		[Embed(source="../../assets/particles/texture_hielo.png")]
		public static const Particle_Hielo:Class;
		
		[Embed(source="../../assets/particles/particle_hielo.pex", mimeType="application/octet-stream")]
		public static const particle_hieloXML:Class;
		
		[Embed(source="../../assets/particles/texture_rapida.png")]
		public static const Particle_Rapida:Class;
		
		[Embed(source="../../assets/particles/particle_rapida.pex", mimeType="application/octet-stream")]
		public static const particle_rapidaXML:Class;
		
		[Embed(source="../../assets/particles/texture_electricidad.png")]
		public static const Particle_Electro:Class;
		
		[Embed(source="../../assets/particles/particle_electricidad.pex", mimeType="application/octet-stream")]
		public static const particle_electroXML:Class;
		
		
		/*
		 * Estas funciones por ahora no se pueden usar porque dan errores al no existir los archivos aun...
		 */
		public static function getFont(name:String):BitmapFont
		{
			var fontTexture:Texture;
			var fontXML:XML;
			switch(name)
			{
				case "FontLevel":
					fontTexture = Texture.fromBitmap(new FontLevel());
					fontXML = XML(new FontXML());
					break;
				case "Banderas":
					fontTexture = Texture.fromBitmap(new Banderas());
					fontXML = XML(new BanderasXML());
					break;
			}
			
			var font:BitmapFont = new BitmapFont(fontTexture, fontXML);
			TextField.registerBitmapFont(font);
			
			return font;
		}
		
		/*public static function getParticleSystem():PDParticleSystem
		{
			var ps:PDParticleSystem = new PDParticleSystem(XML(new ParticlePEX()), Texture.fromBitmap(new ParticleTexture()));
			return ps;
		}*/
		
		public static function getAtlas(name:String):TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture(name);
				var xml:XML;
				switch(name)
				{
				case "levelSelectSprite":
					xml = XML(new levelSelectXML());
					break;
				case "XXXXXX":
					break;
				}
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getParticleSystem(name:String):PDParticleSystem
		{
			var particleTexture:Texture;
			var particleXML:XML;
			switch(name)
			{
				case "Particle_Fuego":
					particleTexture = Texture.fromBitmap(new Particle_Fuego());
					particleXML = XML(new particle_fuegoXML());
					break;
				case "Particle_Hielo":
					particleTexture = Texture.fromBitmap(new Particle_Hielo());
					particleXML = XML(new particle_hieloXML());
					break;
				case "Particle_Rapida":
					particleTexture = Texture.fromBitmap(new Particle_Rapida());
					particleXML = XML(new particle_rapidaXML());
					break;
				case "Particle_Electro":
					particleTexture = Texture.fromBitmap(new Particle_Electro());
					particleXML = XML(new particle_electroXML());
					break;
			}
			
			var ps:PDParticleSystem = new PDParticleSystem(particleXML, particleTexture);
			return ps;
		}
		
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
	}

}