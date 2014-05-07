package utils 
{
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
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
		
		[Embed(source = "../../assets/images/Bicho.png")]
		public static const Soldado:Class;
		
		
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