package utils 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	
	public class VentanaNiveles extends Sprite 
	{
		
		private var arrIzq:Image;
		private var arr:Image;
		private var arrDer:Image;
		private var medIzq:Image;
		private var med:Image;
		private var medDer:Image;
		private var abjIzq:Image;
		private var abj:Image;
		private var abjDer:Image;
		
		private var stars:Image;
		
		private var closeBtn:Button;
		private var playBtn:Button;
		
		public function VentanaNiveles(ancho:int, alto:int, numLvl:int, starsCount:int)
		{
			var datosNv:DatosNivel = new DatosNivel(numLvl);
			
			/*arrIzq = new Image(Assets.getAtlas("levelSelectSprite").getTexture("arrIzq"));
			arr = new Image(Assets.getAtlas("levelSelectSprite").getTexture("arr"));
			arrDer = new Image(Assets.getAtlas("levelSelectSprite").getTexture("arrDer"));
			medIzq = new Image(Assets.getAtlas("levelSelectSprite").getTexture("medIzq"));
			med = new Image(Assets.getAtlas("levelSelectSprite").getTexture("med"));
			medDer = new Image(Assets.getAtlas("levelSelectSprite").getTexture("medDer"));
			abjIzq = new Image(Assets.getAtlas("levelSelectSprite").getTexture("abjIzq"));
			abj = new Image(Assets.getAtlas("levelSelectSprite").getTexture("abj"));
			abjDer = new Image(Assets.getAtlas("levelSelectSprite").getTexture("abjDer"));
			
			arr.width = med.width = abj.width = ancho - arrIzq.width * 2;
			medIzq.height = med.height = medDer.height = alto - arrIzq.height * 2;
			
			arr.x = arrIzq.x + arrIzq.width;
			arrDer.x = arr.x + arr.width;
			
			medIzq.y = arrIzq.y + arrIzq.height;
			medIzq.x = arrIzq.x;
			med.y = arr.y + arrIzq.height;
			med.x = arrIzq.x + arrIzq.width;
			medDer.y = arrDer.y + arrDer.height;
			medDer.x = arr.x + arr.width;
			
			abjIzq.y = medIzq.y + medIzq.height;
			abjIzq.x = medIzq.x;
			abj.y = med.y + medIzq.height;
			abj.x = medIzq.x + medIzq.width;
			abjDer.y = medDer.y + medDer.height;
			abjDer.x = med.x + med.width;
			
			this.addChild(arrIzq);
			this.addChild(arr);
			this.addChild(arrDer);
			this.addChild(medIzq);
			this.addChild(med);
			this.addChild(medDer);
			this.addChild(abjIzq);
			this.addChild(abj);
			this.addChild(abjDer);*/
			
			stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount + "_Estrellas"));
		}
	}

}