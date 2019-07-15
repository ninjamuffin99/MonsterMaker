package;

import flixel.ui.FlxButton;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var baby:Baby;
	private var saving:FlxText;
	private var btnClean:FlxButton;

	private var stats:FlxText;

	override public function create():Void
	{
		saving = new FlxText(10, 300, 0, "SAVING", 32);
		add(saving);

		baby = new Baby(20, 20);
		add(baby);

		stats = new FlxText(40, 200, 0, "Statslol", 32);
		add(stats);

		btnClean = new FlxButton(300, 10, "Clean", function()
		{
			baby.cleanliness = 1;
		});
		add(btnClean);


		if (!Reg.firstRun)
		{
			Reg.firstRun = true;
			FlxG.save.bind("file1");
			Reg.load();
		}
		
		if (Reg.babyTimestamp == 0)
		{
			Reg.babyTimestamp = baby.ageTimestamp.getTime();
			
			Reg.save();
		}
		
		baby.ageCheck();
		
		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			saveGame();
		}, 0);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		stats.text = "Clean: " + baby.cleanliness;

		if (saving.alpha > 0)
		{
			saving.alpha -= 1 * FlxG.elapsed;
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			saveGame();
		}

		super.update(elapsed);
	}

	private function saveGame():Void 
	{
		Reg.babyTimestamp = baby.ageTimestamp.getTime();

		Reg.save();
		saving.alpha = 1;
	}
}
