module GameBot
  class Bot
    MINIMUM_DB_COUNT = 50

    def initialize(config_path = "config.yml")
      @config = YAML.load(File.read(config_path)).freeze
      @database = GameBot::Database.new(@config)
    end

    def populate
      games = generator.generate_games
      @database.insert(games)
    end

    def populate_from_file(filename)
      games = File.readlines(filename).map(&:chomp)
      @database.insert(games)
    end

    def post
      populate_database_if_needed
      game = @database.random_game
      twitter_client.tweet(game[1]) if @config["post_to_twitter"]
      tumblr_client.post(game[1]) if @config["post_to_tumblr"]
      @database.delete(game[0])
    end

    private

    def generator
      @generator ||= GameBot::Generator.new(@config)
    end

    def twitter_client
      @twitter_client = GameBot::TwitterClient.new(@config)
    end

    def tumblr_client
      @tumblr_client = GameBot::TumblrClient.new(@config)
    end

    def populate_database_if_needed
      # Different checkpoints and temperatures will produce slightly different
      # results. In case some are more interesting than others, make sure more
      # than one batch is always available for random selection.
      while @database.count < MINIMUM_DB_COUNT
        populate
      end
    end
  end
end
