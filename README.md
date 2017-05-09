# Game Bot

## Description

This is the bot that posts video game titles generated by recurrent neural networks to the Twitter feed [@RobotGameDev](https://twitter.com/RobotGameDev) and the Tumblr blog [@robot-game-dev](https://robot-game-dev.tumblr.com/), as seen on [Kotaku](http://kotaku.com/computer-creates-fake-video-games-that-sound-better-tha-1794056069) and various game-related podcasts.

The source code may be of limited interest, because it depends on [torch-rnn](https://github.com/jcjohnson/torch-rnn) to generate the game titles themselves. This application serves only to automate the generation process and post the titles to external services.

## Requirements

* A working torch-rnn install, at a path specified in `config.yml`.
* A directory containing one or more torch-rnn checkpoints. The directory must be inside the torch-rnn directory, and the name must be specified in `config.yml`. If more than one checkpoint is present, the script will choose one at random.
* API keys and auth tokens for Twitter and/or Tumblr.

Although I've only used this code for the above bots, it could be used to post another. sort of content generated by torch-rnn. However, it can only read the RNN output one line at a time, so each unit of output (whatever it is) must correspond to a single line.

## Usage

* `bin/game_bot --populate`: Generates content and records it in the SQLite database.
* `bin/game_bot --populate-from-file [FILE]`: Reads content from a text file (one entry per line) and records it in the database.
* `bin/game_bot`: Posts to Twitter and/or Tumblr, as specified in the configuration file. Automatically generates content if the database table falls below 50 rows.

You can use the `--config` and `--database` options to specify config and database files. These default to `config.yml` and `games.db` respectively. If the database does not exist, it will be created.

To run a bot using this script, run it in a cron job. It's unlikely that the script will work in the environment your cron jobs run in. The easiest way around this is to open up a new shell, like so:

    /bin/bash -lc "cd ~/game_bot; bundle exec bin/game_bot >>game_bot.log 2>&1"

If you're using RVM, the shell will need to be a login shell, hence the `-l` option.
