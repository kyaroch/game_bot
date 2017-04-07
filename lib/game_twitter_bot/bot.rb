module GameTwitterBot
  class Bot
    def initialize
      @database = GameTwitterBot::Database.new
    end

    def populate
      games = GameTwitterBot::Generator.generate_games
      @database.insert(games)
    end

    def populate_from_file(filename)
      games = File.readlines(filename).map(&:chomp)
      @database.insert(games)
    end
  end
end
