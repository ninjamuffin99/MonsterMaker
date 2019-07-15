package;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class Reg 
{
	public static var babyTimestamp:Float = 0;
	public static var firstRun:Bool = false;
	
	public static function save():Void
	{
		FlxG.save.data.babyTimestamp = babyTimestamp;
		
		FlxG.save.flush();
	}
	
	public static function load():Void
	{
		babyTimestamp = FlxG.save.data.babyTimestamp;
	}
}