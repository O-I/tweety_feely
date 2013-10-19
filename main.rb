require_relative 'config'

topics = %w(happy sad angry afraid)
feely_tweets = []
i = 0

@streaming_client.filter(track: topics.join(",")) do |tweet|
  if tweet.lang == 'en'
    i += 1
    feely_tweets << {user: tweet.attrs[:user][:screen_name], tweet: tweet.text}
    puts "#{i} tweets gathered"
    puts "#{tweet.attrs[:user][:screen_name]} tweeted about feelings: #{tweet.text}"
  end
  break if i > 100
end

words = feely_tweets.map { |tweet_datum| tweet_datum[:tweet].split(' ') }.flatten!