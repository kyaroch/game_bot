$LOAD_PATH.unshift File.dirname(__FILE__)
require 'game_twitter_bot/bot'
require 'game_twitter_bot/database'
require 'game_twitter_bot/generator'
require 'yaml'

module GameTwitterBot
  CONFIG = YAML.load(File.read("config.yml")).freeze
end
