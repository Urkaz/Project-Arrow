VentanaNiveles

package utils 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Button;
	import starling.text.TextField;
	
	public class VentanaNiveles extends Sprite 
	{
		
		private var numeroNivel:TextField;

		private var selector:Image;
		private var stars:Image;
		
		private var closeBtn:Button;
		private var playBtn:Button;
		
		//public function VentanaNiveles(numLvl:int, starsCount:int)
		public function VentanaNiveles(numLvl:int)
		{
			var datosNv:DatosNivel = new DatosNivel(numLvl);
			
			closeBtn = new Button(Assets.getTexture("Boton_Atras"));
			playBtn = new Button(Assets.getTexture("Boton_Start"));
			selector = new Image(Assets.getTexture("Selector_Tierra"));
			
			//stars = new Image(Assets.getAtlas("levelSelectSprite").getTexture(starsCount + "_Estrellas"));
			
			numeroNivel = new TextField(300, 220,"NiVeL " + String(numLvl) , Assets.getFont("Banderas").name, 85, 0xffffff);
			
			numeroNivel.x = this.x + selector.width / 2 - numeroNivel.width / 2;
			numeroNivel.y = this.y + selector.width / 2 - ( numeroNivel.height / 2 - 32);
			
			closeBtn.x = this.x + selector.width / 2 - closeBtn.width / 2;
			closeBtn.y = this.y + selector.width / 2 - closeBtn.height / 2;
			
			playBtn.x = this.x + selector.width / 2 - playBtn.width / 2;
			playBtn.y = this.y + selector.width / 2 - playBtn.height / 2;
			
			this.addChild(selector);
			this.addChild(numeroNivel)
			
			
			this.addChild(closeBtn);
			this.addChild(playBtn);
			
			
			
			
		}
	}

}
