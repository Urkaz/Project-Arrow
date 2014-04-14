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
		
	
		[Embed(source="../../assets/levels/TestLevel.xml", mimeType="application/octet-stream")]
		public static const nivelDePrueba:Class;
		
		[Embed(source="../../assets/images/Welcomenotitle.png")]
		public static const FondoWelcome:Class;
		
		[Embed(source="../../assets/images/titulo_welcome.png")]
		public static const TituloWelcome:Class;
		
		[Embed(source="../../assets/images/arrow.png")]
		public static const Arrow:Class;
		
		
		[Embed(source="../../assets/images/Welcome_boton.png")]
		public static const BotonWelcome:Class;
		
		[Embed(source="../../assets/images/Muralla_Hierba.png")]
		public static const MurallaHierba:Class;
		
		[Embed(source="../../assets/images/Pantalla_niveles.png")]
		public static const NivelesPrueba:Class;
	
		
		
		/*
		 * Estas funciones por ahora no se pueden usar porque dan errores al no existir los archivos aun...
		 *
		public static function getFont():BitmapFont
		{
			var fontTexture:Texture = Texture.fromBitmap(new FontTexture());
			var fontXML:XML = XML(new FontXML());
			
			var font:BitmapFont = new BitmapFont(fontTexture, fontXML);
			TextField.registerBitmapFont(font);
			
			return font;
		}
		
		public static function getParticleSystem():PDParticleSystem
		{
			var ps:PDParticleSystem = new PDParticleSystem(XML(new ParticlePEX()), Texture.fromBitmap(new ParticleTexture()));
			return ps;
		}
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		*/
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