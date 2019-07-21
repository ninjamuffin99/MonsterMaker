package;

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
class Baby extends FlxText 
{
	private var happiness:Float = 0;
	private var ageProgress:Float = 0;
	private var age:Int = 0;
	public var cleanliness:Float = 1;
	public var entertainment:Float = 1;
	public var hungry:Float = 1;
	
	public var ageTimestamp:Date = Date.now();
	private var babyID:Int = 0;

	private var stupid:DummyBruh;

	public function new(?X:Float=0, ?Y:Float=0, id:Int = 0, stupid:DummyBruh) 
	{
		//super(X, Y);
		super(X, Y, 0, "bruh", 32);
		babyID = id;

		this.stupid = stupid;

	}//
	
	public function ageCheck():Void
	{
		var delta:Float = ageTimestamp.getTime() - Reg.babyTimestamp;
		FlxG.log.add(delta + "ms " + (delta / 1000));
		var frames:Float = delta / (FlxG.elapsed * 1000);
		FlxG.log.add(frames + " frames " + (frames / FlxG.updateFramerate) + " s");
	}
	
	override public function update(elapsed:Float):Void 
	{
		setPosition(stupid.x, stupid.y);

		ageProgress += elapsed;

		if (cleanliness > 0)
			cleanliness -= elapsed * 0.001;
		if (hungry > 0)
			hungry -= elapsed * 0.01;
		
		if (entertainment > 0)
			entertainment -= elapsed * 0.05;

		super.update(elapsed);

		
	}
	
}