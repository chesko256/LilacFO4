Lilac
9/14/2016
Version 1.2

### A Papyrus Testing Framework

Lilac is a unit testing framework for Papyrus. It has a simple and direct syntax so that you can easily write tests to increase the quality of your mods.

It is inspired by [Jasmine](http://jasmine.github.io) for Javascript. It is currently available for **Fallout 4** and **[Skyrim](https://github.com/chesko256/Lilac)**.

Lilac can be built into your mod and distributed with it. Your tests will only run when you decide to run them; your users will most likely never know they exist.

### Documentation

Documentation can be found on the Lilac GitHub Wiki: https://github.com/chesko256/LilacFO4/wiki

### Requirements

Lilac does not have any extra requirements for Fallout 4.

### Installation
All of Lilac is contained in a single script file, **Lilac.psc**. There is no complex set-up or installation.

Download and install the [latest release](https://github.com/chesko256/LilacFO4/releases) using a mod manager, or just drop Lilac.psc into your `Scripts/Source` directory. Then, create a new script that extends Lilac and away you go:

    scriptname MyTests extends Lilac

### Writing Tests
Lilac allows you to write tests in a clear and expressive syntax.

    function MonsterSpawnerSuite()

        it ( "should spawn monsters", MonsterSpawnerTest() )

    endFunction


    function MonsterSpawnerTest()

        spawner.SpawnMonsters()
        expect ( spawner.SpawnedMonsterCount, to, beEqualTo, 20 )
        expect ( spawner.LastSpawnedMonster, notTo, beNone )
        expect ( spawner.LastSpawnedMonsterType, to, beEqualTo, MegaDragon )

    endFunction

### Running Tests
Lilac test scripts are attached to quests. To run your tests, just start the quest:
    
    startquest MyTestQuest

The results will be printed to your Papyrus log.

### Version History

v1.2: Initial Fallout 4 version.

### License
Lilac is released under the [MIT License](https://github.com/chesko256/LilacFO4/blob/master/MIT.LICENSE).

### Contact
Contact Chesko at chesko.tesmod@gmail.com