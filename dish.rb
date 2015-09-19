require "./boot"
require "twitter"
require "htmlentities"

# A dish to catch all tweets about a hashtag. Calling this in a cron job, so it
# won't be real time, but it will be good enough. Yay!
class Dish
  def self.point_at_tom
    credentials = { "consumer_key" => ENV["TWITTER_CONSUMER_KEY"],
                    "consumer_secret" => ENV["TWITTER_CONSUMER_SECRET"],
                    "access_token" => ENV["TWITTER_OAUTH_TOKEN"],
                    "token_secret" => ENV["TWITTER_OATH_TOKEN_SECRET"] }
    new("#radartom", credentials)
  end

  # To setup the dish we need:
  #
  # hashtag - #radartom (# needs to be included)
  # credentials - a hash containing the Twitter API credentials
  def initialize(hashtag, credentials)
    @hashtag = hashtag
    @credentials = credentials
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = @credentials["consumer_key"]
      config.consumer_secret     = @credentials["consumer_secret"]
      config.access_token        = @credentials["access_token"]
      config.access_token_secret = @credentials["token_secret"]
    end
  end

  def crawl_hashtag
    options = { result_type: :recent }
    if Tweet.count > 0
      options.merge!(since_id: Tweet.order(:posted_at).last.tweet_id)
    end
    log "Start crawl: Looking for tweets with '#{@hashtag}'..."
    client.search(@hashtag, options).attrs.fetch(:statuses, []).each do |tweet|
      process_tweet(tweet)
    end
    log "Stop crawl"
  end

  def process_tweet(tweet_details)
    name = tweet_details.fetch(:user, {}).fetch(:screen_name).downcase
    profile_image_url = tweet_details.fetch(:user, {}).fetch(:profile_image_url)
    text = decode_full_text(tweet_details.fetch(:text))
    log "%s: %s" % [name, text]
    t = Tweet.find_or_create(tweet_id: tweet_details.fetch(:id_str).to_s)
    t.name = name
    t.posted_at = Time.parse(tweet_details.fetch(:created_at))
    t.text = text
    t.profile_image = profile_image_url
    t.save
  end

  def decode_full_text(text)
    HTMLEntities.new.decode(text)
  end

  def log(*args)
    puts args
  end
end
