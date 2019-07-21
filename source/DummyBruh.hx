package;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.debug.log.Log;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author 
 */
class DummyBruh extends FlxSprite
{

    private var _brain:FSM;
	private var _idleTmr:Float = 1;
	private var _moveDir:Float;

	private var speed = 150;

	public var mousePressing:Bool = false;
	private var mouseOffset:FlxPoint = FlxPoint.get(0, 0);
	

    public function new(X:Float, Y:Float)
    {
        super(X, Y);
        _brain = new FSM(idle);
		drag.x = drag.y = 2500;
		drag.x = drag.y = drag.x * 0.07;
        makeGraphic(100, 60, FlxColor.RED);
		alpha = 0.1;

		FlxMouseEventManager.add(this, winDragSet);
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
        _brain.update();

		if (mousePressing && FlxG.mouse.x >= 0 && FlxG.mouse.x <= FlxG.width && FlxG.mouse.y >= 0 && FlxG.mouse.y <= FlxG.height)
		{
			this.x = FlxG.mouse.x - mouseOffset.x;
			this.y = FlxG.mouse.y - mouseOffset.y;
		}
		
		if (FlxG.mouse.justReleased)
		{
			mousePressing = false;
		}
    }

    
	public function idle():Void
	{
		if (_idleTmr <= 0)
		{
			FlxG.log.add("SHOULD HAVE MOVED");
			if (FlxG.random.bool(1))
			{
				
				_moveDir = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				FlxG.log.add("TRIED TO MOVE");
				_moveDir = FlxG.random.int(0, 8) * 45;
				
				velocity.set(speed * 0.8, 0);
				velocity.rotate(FlxPoint.weak(), _moveDir);
			}
			_idleTmr = FlxG.random.float(1, 5);
		}
		else
			_idleTmr -= FlxG.elapsed;
	}

	private function winDragSet(_)
	{
		mousePressing = true;
		mouseOffset.set(FlxG.mouse.x - this.x, FlxG.mouse.y - this.y);
	}

}