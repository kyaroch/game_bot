module GameTwitterBot
  class Bot
    def initialize
      @database = GameTwitterBot::Database.new
    end

    def populate
      GameTwitterBot::Generator.generate_games
                               .each { |game| @database.insert(game) }
    end
  end
end
