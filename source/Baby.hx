package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author 
 */
class Baby extends FlxSprite 
{
	private var happiness:Float = 0;
	private var ageProgress:Float = 0;
	private var age:Int = 0;
	public var cleanliness:Float = 1;
	public var hungry:Float = 1;
	
	public var ageTimestamp:Date = Date.now();
	private var babyID:Int = 0;
	
	public function new(?X:Float=0, ?Y:Float=0, id:Int = 0) 
	{
		super(X, Y);
		babyID = id;
		makeGraphic(64, 64);
	}
	
	public function ageCheck():Void
	{
		var delta:Float = ageTimestamp.getTime() - Reg.babyTimestamp;
		FlxG.log.add(delta + "ms " + (delta / 1000));
		var frames:Float = delta / (FlxG.elapsed * 1000);
		FlxG.log.add(frames + " frames " + (frames / FlxG.updateFramerate) + " s");
	}
	
	override public function update(elapsed:Float):Void 
	{
		ageProgress += elapsed;

		if (cleanliness > 0)
			cleanliness -= elapsed * 0.001;
		if (hungry > 0)
			hungry -= elapsed * 0.01;

		super.update(elapsed);
	}
	
}