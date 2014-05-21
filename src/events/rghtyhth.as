package
{
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
	import starling.extensions.PDParticleSystem;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import starling.text.TextField;

	public class Assets
	{
		[Embed(source="../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		[Embed(source="../media/graphics/bgLayer1.jpg")]
		public static const BgLayer1:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../media/graphics/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		[Embed(source="../media/fonts/myFont.png")]
		public static const FontTexture:Class;
		
		[Embed(source="../media/fonts/myFont.fnt", mimeType="application/octet-stream")]
		public static const FontXML:Class;
		
		
		
		[Embed(source="../media/particles/texture2.png")]
		public static const ParticleTexture:Class;
		
		[Embed(source="../media/particles/particle.pex", mimeType="application/octet-stream")]
		public static const particleXML:Class;
		
		
		
		public static var myFont:BitmapFont;
		
		//[Embed(source="../media/fonts/embedded/BADABB__.TTF", fontFamily="MyFontName", embedAsCFF="false")]
		//public static var MyFont:Class;
		
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
			var psConfig:XML = XML(new particleXML());
			var psTexture:Texture = Texture.fromBitmap(new ParticleTexture());
			var ps:PDParticleSystem = new PDParticleSystem(psConfig, psTexture);
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