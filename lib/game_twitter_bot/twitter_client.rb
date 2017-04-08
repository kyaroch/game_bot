module GameTwitterBot
  class TwitterClient
    def initialize(bot_config)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = bot_config["twitter_api_key"]
        config.consumer_secret     = bot_config["twitter_api_secret"]
        config.access_token        = bot_config["twitter_access_token"]
        config.access_token_secret = bot_config["twitter_access_token_secret"]
      end
    end

    def tweet(text)
      @client.update(text)
    end
  end
end
