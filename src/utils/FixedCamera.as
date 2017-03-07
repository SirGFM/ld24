package utils {
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * The basic FlxCamera with some fixes that allow it to smoothly follow a FlxObject.
	 * 
	 * @link http://forums.flixel.org/index.php?topic=4543.0
	 * @link https://github.com/krix/CameraScrollFix
	 * 
	 * @author krix
	 */
	public class FixedCamera extends FlxCamera{
		
		/**
		 * Camera "follow" style preset: camera will move screenwise.
		 */
		static public const STYLE_SCREEN_BY_SCREEN:uint = 4;
		/**
		 * Tells the camera to use this following style.
		 */
		public var style:uint;
		
		/**
		 * Instantiates a new camera at the specified location, with the specified size and zoom level.
		 * 
		 * @param X			X location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
		 * @param Y			Y location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
		 * @param Width		The width of the camera display in pixels.
		 * @param Height	The height of the camera display in pixels.
		 * @param Zoom		The initial zoom level of the camera.  A zoom level of 2 will make all pixels display at 2x resolution.
		 */
		public function FixedCamera(X:int,Y:int,Width:int,Height:int,Zoom:Number=0)
		{
			super(X, Y, Width, Height, Zoom);
		}
		
		override public function update():void
		{
			//Either follow the object closely, 
			//or doublecheck our deadzone and update accordingly.
			if(target != null)
			{
				if(deadzone == null)
					focusOn(target.getMidpoint(_point));
				else
				{
					var edge:Number;
					var targetX:Number;
					var targetY:Number;
					
					if (simpleRender(FlxSprite(target))) {
						targetX = FlxU.ceil(target.x + ((target.x > 0)?0.0000001:-0.0000001));
						targetY = FlxU.ceil(target.y + ((target.y > 0)?0.0000001:-0.0000001));
					}
					else{
						targetX = target.x + ((target.x > 0)?0.0000001:-0.0000001);
						targetY = target.y + ((target.y > 0)?0.0000001: -0.0000001);
					}
					
					if (style == STYLE_SCREEN_BY_SCREEN) {
						if(targetX > scroll.x + width){
							scroll.x += width;
						}
						else if(targetX < scroll.x){
							scroll.x -= width;
						}
						
						if(targetY > scroll.y + height){
							scroll.y += height;
						}
						else if(targetY < scroll.y){
							scroll.y -= height;
						}
					}
					else{
						edge = targetX - deadzone.x;
						if(scroll.x > edge)
							scroll.x = edge;
						edge = targetX + target.width - deadzone.x - deadzone.width;
						if(scroll.x < edge)
							scroll.x = edge;
						
						edge = targetY - deadzone.y;
						if(scroll.y > edge)
							scroll.y = edge;
						edge = targetY + target.height - deadzone.y - deadzone.height;
						if(scroll.y < edge)
							scroll.y = edge;
					}
				}
			}
			
			//Make sure we didn't go outside the camera's bounds
			if(bounds != null)
			{
				if(scroll.x < bounds.left)
					scroll.x = bounds.left;
				if(scroll.x > bounds.right - width)
					scroll.x = bounds.right - width;
				if(scroll.y < bounds.top)
					scroll.y = bounds.top;
				if(scroll.y > bounds.bottom - height)
					scroll.y = bounds.bottom - height;
			}
			
			//Update the "flash" special effect
			if(_fxFlashAlpha > 0.0)
			{
				_fxFlashAlpha -= FlxG.elapsed/_fxFlashDuration;
				if((_fxFlashAlpha <= 0) && (_fxFlashComplete != null))
					_fxFlashComplete();
			}
			
			//Update the "fade" special effect
			if((_fxFadeAlpha > 0.0) && (_fxFadeAlpha < 1.0))
			{
				_fxFadeAlpha += FlxG.elapsed/_fxFadeDuration;
				if(_fxFadeAlpha >= 1.0)
				{
					_fxFadeAlpha = 1.0;
					if(_fxFadeComplete != null)
						_fxFadeComplete();
				}
			}
			
			//Update the "shake" special effect
			if(_fxShakeDuration > 0)
			{
				_fxShakeDuration -= FlxG.elapsed;
				if(_fxShakeDuration <= 0)
				{
					_fxShakeOffset.make();
					if(_fxShakeComplete != null)
						_fxShakeComplete();
				}
				else
				{
					if((_fxShakeDirection == SHAKE_BOTH_AXES) || (_fxShakeDirection == SHAKE_HORIZONTAL_ONLY))
						_fxShakeOffset.x = (FlxG.random()*_fxShakeIntensity*width*2-_fxShakeIntensity*width)*_zoom;
					if((_fxShakeDirection == SHAKE_BOTH_AXES) || (_fxShakeDirection == SHAKE_VERTICAL_ONLY))
						_fxShakeOffset.y = (FlxG.random()*_fxShakeIntensity*height*2-_fxShakeIntensity*height)*_zoom;
				}
			}
		}
		
		override public function follow(Target:FlxObject, Style:uint=STYLE_LOCKON):void
		{
			style = Style;
			target = Target;
			var helper:Number;
			var w:Number = 0;
			var h:Number = 0;
			
			switch(Style)
			{
				case STYLE_PLATFORMER:
					w = width/8;
					h = height/3;
					deadzone = new FlxRect((width-w)/2,(height-h)/2 - h*0.25,w,h);
					break;
				case STYLE_TOPDOWN:
					helper = FlxU.max(width,height)/4;
					deadzone = new FlxRect((width-helper)/2,(height-helper)/2,helper,helper);
					break;
				case STYLE_TOPDOWN_TIGHT:
					helper = FlxU.max(width,height)/8;
					deadzone = new FlxRect((width-helper)/2,(height-helper)/2,helper,helper);
					break;
				case STYLE_LOCKON:
					if (target != null) {	
						w = target.width;
						h = target.height;
					}
					deadzone = new FlxRect((width-w)/2,(height-h)/2 - h * 0.25,w,h);
					break;
				case STYLE_SCREEN_BY_SCREEN:
					deadzone = new FlxRect(0, 0, width, height);
					break;	
				default:
					deadzone = null;
					break;
			}
		}
		
		/**
		 * If the Sprite is beeing rendered in simple mode.
		 */
		public function simpleRender(sprite:FlxSprite):Boolean { 
			//return ((sprite.angle == 0) || (sprite._bakedRotation > 0)) && (sprite.scale.x == 1) && (sprite.scale.y == 1) && (sprite.blend == null)
			return (sprite.scale.x == 1) && (sprite.scale.y == 1) && (sprite.blend == null);
		}
	}
}