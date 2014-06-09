package utils 
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
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameAtlas:Dictionary = new Dictionary();
		
		// NIVELES //
		[Embed(source="../../assets/levels/LevelList.xml", mimeType="application/octet-stream")]
		public static const levelList:Class;
		
		[Embed(source="../../assets/levels/TestLevel.xml", mimeType="application/octet-stream")]
		public static const nivel0:Class;
		
		[Embed(source="../../assets/levels/level1.xml", mimeType="application/octet-stream")]
		public static const nivel1:Class;
		
		[Embed(source="../../assets/levels/level2.xml", mimeType="application/octet-stream")]
		public static const nivel2:Class;
		
		[Embed(source="../../assets/levels/level3.xml", mimeType="application/octet-stream")]
		public static const nivel3:Class;
		
		[Embed(source="../../assets/levels/level4.xml", mimeType="application/octet-stream")]
		public static const nivel4:Class;
		
		[Embed(source="../../assets/levels/level5.xml", mimeType="application/octet-stream")]
		public static const nivel5:Class;
		
		[Embed(source="../../assets/levels/level6.xml", mimeType="application/octet-stream")]
		public static const nivel6:Class;
		
		[Embed(source="../../assets/levels/level7.xml", mimeType="application/octet-stream")]
		public static const nivel7:Class;
		
		[Embed(source="../../assets/levels/level8.xml", mimeType="application/octet-stream")]
		public static const nivel8:Class;
		
		[Embed(source="../../assets/levels/level9.xml", mimeType="application/octet-stream")]
		public static const nivel9:Class;
		
		[Embed(source="../../assets/levels/level10.xml", mimeType="application/octet-stream")]
		public static const nivel10:Class;
		
		[Embed(source="../../assets/levels/level11.xml", mimeType="application/octet-stream")]
		public static const nivel11:Class;
		
		[Embed(source="../../assets/levels/level12.xml", mimeType="application/octet-stream")]
		public static const nivel12:Class;
		
		[Embed(source="../../assets/levels/level13.xml", mimeType="application/octet-stream")]
		public static const nivel13:Class;
		
		[Embed(source="../../assets/levels/level14.xml", mimeType="application/octet-stream")]
		public static const nivel14:Class;
		
		[Embed(source="../../assets/levels/level15.xml", mimeType="application/octet-stream")]
		public static const nivel15:Class;
		
		// FUENTES //
		[Embed(source="../../assets/fonts/font.png")]
		public static const FontLevel:Class;
		
		[Embed(source="../../assets/fonts/font.fnt", mimeType="application/octet-stream")]
		public static const FontXML:Class;
		
		[Embed(source="../../assets/fonts/banderas.png")]
		public static const Banderas:Class;
		
		[Embed(source="../../assets/fonts/banderas.fnt", mimeType="application/octet-stream")]
		public static const BanderasXML:Class;
		
		[Embed(source="../../assets/fonts/textos.png")]
		public static const Textos:Class;
		
		[Embed(source="../../assets/fonts/textos.fnt", mimeType="application/octet-stream")]
		public static const TextosXML:Class;
		
		// IMAGENES //
		//Español
		[Embed(source="../../assets/images/reglas_es.xml", mimeType="application/octet-stream")]
		public static const reglas_esXML:Class;
		
		[Embed(source="../../assets/images/reglas_es.png")]
		public static const reglas_es:Class;
		
		[Embed(source="../../assets/images/botones_es.xml", mimeType="application/octet-stream")]
		public static const botones_esXML:Class;
		
		[Embed(source="../../assets/images/botones_es.png")]
		public static const botones_es:Class;
		
		//Inglés
		[Embed(source="../../assets/images/reglas_en.xml", mimeType="application/octet-stream")]
		public static const reglas_enXML:Class;
		
		[Embed(source="../../assets/images/reglas_en.png")]
		public static const reglas_en:Class;
		
		[Embed(source="../../assets/images/botones_en.xml", mimeType="application/octet-stream")]
		public static const botones_enXML:Class;
		
		[Embed(source="../../assets/images/botones_en.png")]
		public static const botones_en:Class;
		
		[Embed(source="../../assets/images/levelSelection.xml", mimeType="application/octet-stream")]
		public static const levelSelectXML:Class;
		
		//General
		[Embed(source="../../assets/images/levelSelection.png")]
		public static const levelSelectSprite:Class;
		
		[Embed(source="../../assets/images/levelGame.xml", mimeType="application/octet-stream")]
		public static const gameXML:Class;
		
		[Embed(source="../../assets/images/levelGame.png")]
		public static const gameSprite:Class;
		
		[Embed(source="../../assets/images/PantallaInicial.png")]
		public static const PantallaInicial:Class;
		
		// PARTÍCULAS //
		[Embed(source="../../assets/particles/particle_fuego.pex", mimeType="application/octet-stream")]
		public static const particle_fuegoXML:Class;
		
		[Embed(source="../../assets/particles/particle_hielo.pex", mimeType="application/octet-stream")]
		public static const particle_hieloXML:Class;
		
		[Embed(source="../../assets/particles/particle_rapida.pex", mimeType="application/octet-stream")]
		public static const particle_rapidaXML:Class;
		
		[Embed(source="../../assets/particles/particle_electricidad.pex", mimeType="application/octet-stream")]
		public static const particle_electroXML:Class;
		
		[Embed(source="../../assets/particles/particle_planta.pex", mimeType="application/octet-stream")]
		public static const particle_plantXML:Class;
		
		[Embed(source="../../assets/particles/texture_circle.png")]
		public static const Particle_circle:Class;
		
		[Embed(source="../../assets/particles/texture_planta.png")]
		public static const Particle_plant:Class;
		
		//MUSICA//
		
		[Embed(source="../../assets/Music/TheHunter.mp3")]
		public static const hunter:Class;
		
		[Embed(source="../../assets/Music/ThinkTank.mp3")]
		public static const music_selection:Class;
		
		[Embed(source="../../assets/Music/BustinLooseWLead.mp3")]
		public static const music_level1:Class;
		
		[Embed(source="../../assets/Music/PilotsOfStone.mp3")]
		public static const music_level2:Class;
		
		
		//Funciones
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
				case "Textos":
					fontTexture = Texture.fromBitmap(new Textos());
					fontXML = XML(new TextosXML());
					break;
			}
			
			var font:BitmapFont = new BitmapFont(fontTexture, fontXML);
			TextField.registerBitmapFont(font);
			
			return font;
		}
		
		public static function getAtlas(name:String):TextureAtlas
		{
			if (gameAtlas[name] == undefined)
			{
				var texture:Texture = getTexture(name);
				var xml:XML;
				switch(name)
				{
				case "levelSelectSprite":
					xml = XML(new levelSelectXML());
					break;
				case "gameSprite":
					xml = XML(new gameXML());
					break;
				case "reglas_es":
					xml = XML(new reglas_esXML());
					break;
				case "botones_es":
					xml = XML(new botones_esXML());
					break;
				case "reglas_en":
					xml = XML(new reglas_enXML());
					break;
				case "botones_en":
					xml = XML(new botones_enXML());
					break;
				}
				gameAtlas[name] = new TextureAtlas(texture, xml);
			}
			return gameAtlas[name];
		}
		
		public static function getParticleSystem(name:String):PDParticleSystem
		{
			var particleTexture:Texture;
			var particleXML:XML;
			switch(name)
			{
				case "Particle_fire":
					particleTexture = Texture.fromBitmap(new Particle_circle());
					particleXML = XML(new particle_fuegoXML());
					break;
				case "Particle_ice":
					particleTexture = Texture.fromBitmap(new Particle_circle());
					particleXML = XML(new particle_hieloXML());
					break;
				case "Particle_fast":
					particleTexture = Texture.fromBitmap(new Particle_circle());
					particleXML = XML(new particle_rapidaXML());
					break;
				case "Particle_elec":
					particleTexture = Texture.fromBitmap(new Particle_circle());
					particleXML = XML(new particle_electroXML());
					break;
				case "Particle_plant":
					particleTexture = Texture.fromBitmap(new Particle_plant());
					particleXML = XML(new particle_plantXML());
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