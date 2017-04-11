#!/usr/bin/env ruby

require 'optparse'
require 'lib/game_bot'

options = { file: nil, populate: false, config_path: nil, db_path: nil }

parser = OptionParser.new do |opts|
  opts.on("--populate", "Populate database") do
    options[:populate] = true
  end

  opts.on("--populate-from-file file", "Populate from file") do |file|
    options[:file] = file
  end

  opts.on("--config file", "Config file path") do |file|
    options[:config_path] = file
  end

  opts.on("--database database", "Database path") do |db|
    options[:db_path] = db
  end
end

parser.parse!

bot = GameBot::Bot.new(
  config_path: options[:config_path], db_path: options[:db_path]
)

if options[:populate]
  bot.populate
elsif options[:file]
  bot.populate_from_file(options[:file])
else
  bot.post
end
