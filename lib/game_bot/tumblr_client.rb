module GameBot
  class TumblrClient
    def initialize(bot_config)
      Tumblr.configure do |config|
        config.consumer_key = bot_config["tumblr_consumer_key"]
        config.consumer_secret = bot_config["tumblr_consumer_secret"]
        config.oauth_token = bot_config["tumblr_access_token"]
        config.oauth_token_secret = bot_config["tumblr_access_token_secret"]
      end
      @url = bot_config["tumblr_url"]
      @client = Tumblr::Client.new
    end

    def post(game)
      @client.text(@url, body: game)
    end
  end
end
