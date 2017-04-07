module GameTwitterBot
  class Bot
    def initialize
      @database = GameTwitterBot::Database.new
    end

    def populate
      games = GameTwitterBot::Generator.generate_games
      @database.insert(games)
    end
  end
end
