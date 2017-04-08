module GameTwitterBot
  class Generator
    # You must have a torch-rnn installation at config["rnn_path"] with one or
    # more checkpoint files in the subdirectory specified by
    # config["checkpoint_directory"]

    def self.config
      GameTwitterBot::CONFIG
    end

    def self.generate_games
      # First and last lines are usually fragmentary
      lines = run_rnn.split("\n")[1..-2]
      lines.map! { |line| format_line(line) }
           .select! { |line| line.length <= 140 }
    end

    def self.run_rnn
      Dir.chdir(config["rnn_path"])
      filename = Dir.entries(config["checkpoint_directory"])
                    .select { |filename| filename =~ /\.t7$/ }
                    .sample
      # To run this on a GPU, change -gpu from -1
      `th sample.lua -checkpoint cv/#{filename} -gpu -1 -temperature #{temperature}`
    end

    def self.temperature
      # Higher temperature means the RNN will select less probable characters.
      # Temperature 0.7 - 0.9 seems to produce the best results.
      0.7 + [0.0, 0.1, 0.2].sample
    end

    def self.format_line(line)
      # Source list has some formatting problems, fix them here for cosmetic
      # reasons
      line.gsub(/\?+/, "?")
          .gsub(/\;[^\w]+\)/, ")")
          .gsub(";", "; ")
          .gsub(/\s+/, " ")
    end
  end
end
