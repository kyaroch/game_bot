module GameTwitterBot
  class Database
    def initialize
      @db = SQLite3::Database.new("games.db")
      initialize_table
    end

    def insert(names)
      Array(names).each do |name|
        @db.execute("INSERT INTO games (name) VALUES (?);", name)
      end
    end

    def random_game
      @db.execute("SELECT * FROM games ORDER BY RANDOM() LIMIT 1;")[0]
    end

    def delete(id)
      @db.execute("DELETE FROM games WHERE id = ?;", id)
    end

    private

    def initialize_table
      @db.execute(
        "CREATE TABLE IF NOT EXISTS games (id INTEGER PRIMARY KEY, name STRING, " \
        "CONSTRAINT unique_name UNIQUE (name) ON CONFLICT IGNORE);"
      )
    end
  end
end
