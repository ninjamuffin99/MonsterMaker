package;

import flixel.ui.FlxBar;
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
	private var brClean:FlxBar;
	private var brHungry:FlxBar;

	override public function create():Void
	{
		saving = new FlxText(10, 300, 0, "SAVING", 32);
		add(saving);

		var dum:DummyBruh = new DummyBruh(200, 200);
		add(dum);

		baby = new Baby(200, 200, 0, dum);
		add(baby);


		stats = new FlxText(40, 200, 0, "Statslol", 32);
		//add(stats);

		btnClean = new FlxButton(300, 10, "Clean", function()
		{
			baby.cleanliness = 1;
			bruh();
		});
		add(btnClean);

	

		brClean = new FlxBar(btnClean.x, btnClean.y + 20, null, 100, 10, baby, "cleanliness", 0, 1);
		add(brClean);

		var btnFeed:FlxButton = new FlxButton(brClean.x, brClean.y + 25, "Feed", function()
		{
			baby.hungry = 1;
			bruh();
		});
		add(btnFeed);

		brHungry = new FlxBar(btnFeed.x, btnFeed.y + 25, null, 100, 10, baby, "hungry", 0, 1);
		add(brHungry);

		var btnPlay:FlxButton = new FlxButton(brHungry.x, brHungry.y + 20, "PLAY", function()
		{
			baby.entertainment = 1;
			bruh();
		});
		add(btnPlay);

		var brPlay:FlxBar = new FlxBar(btnPlay.x, btnPlay.y + 20, null, 100, 10, baby, "entertainment", 0, 1);
		add(brPlay);


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

	private function bruh():Void 
	{
		FlxG.sound.play(AssetPaths.bruh__mp3);
	}
}
