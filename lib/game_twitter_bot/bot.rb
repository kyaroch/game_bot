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

    private

    def generator
      @generator ||= GameTwitterBot::Generator.new(config)
    end
  end
end
