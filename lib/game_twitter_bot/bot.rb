module GameTwitterBot
  class Bot
    def initialize(config_path = "config.yml")
      @config = YAML.load(File.read(config_path)).freeze
      @database = GameTwitterBot::Database.new(@config)
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
      game = @database.random_game
      twitter_client.tweet(game[1])
    end

    private

    def generator
      @generator ||= GameTwitterBot::Generator.new(@config)
    end

    def twitter_client
      @twitter_client = GameTwitterBot::TwitterClient.new(@config)
    end
  end
end
