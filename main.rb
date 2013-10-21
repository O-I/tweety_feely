require_relative 'config'

topics = ["happy", "festive", "content", "relaxed", "calm", "complacent", "satisfied", "serene", "comfortable", "peaceful", "joyful", "ecstatic", "enthusiastic", "inspired", "glad", "pleased", "grateful", "cheerful", "excited", "lighthearted", "buoyant", "carefree", "surprised", "optimistic", "spirited", "vivacious", "brisk", "sparkling", "merry", "generous", "hilarious", "exhilarated", "delighted", "jolly", "playful", "elated", "jubilant", "thrilled", "silly", "giddy", "eager", "keen", "earnest", "intent", "zealous", "ardent", "avid", "proud", "excited", "desirous", "hungry", "thirsty", "sad", "sorrowful", "unhappy", "depressed", "melancholy", "gloomy", "somber", "solemn", "dismal", "mournful", "dreadful", "blah", "meh", "dull", "sullen", "moody", "sulky", "low", "discontent", "discouraged", "disappointed", "concerned", "sympathetic", "resolute", "embarrassed", "ashamed", "useless", "worthless", "uneasy", "ill", "sick", "empty", "hurt", "horrible", "isolated", "offended", "distressed", "suffering", "afflicted", "crushed", "heartbroken", "cold", "upset", "lonely", "despairing", "pathetic", "angry", "mad", "resentful", "irritated", "enraged", "furious", "annoyed", "inflamed", "provoked", "indignant", "adversarial", "defiant", "irate", "wrathful", "cross", "bitter", "frustrated", "grumpy", "stubborn", "belligerent", "confused", "awkward", "bewildered", "fearless", "encouraged", "courageous", "confident", "secure", "independent", "bold", "brave", "daring", "heroic", "hardy", "healthy", "determined", "loyal", "impulsive", "interested", "amused", "tickled", "concerned", "fascinated", "engrossed", "intrigued", "absorbed", "curious", "inquisitive", "creative", "sincere", "doubtful", "unbelieving", "skeptical", "distrustful", "suspicious", "uncertain", "hesitant", "perplexed", "indecisive", "hopeless", "powerless", "helpless", "defeated", "pessimistic", "uptight", "paralyzed", "tense", "hollow", "empty", "frisky", "strong", "weak", "breathless", "nauseated", "sluggish", "weary", "repulsed", "tired", "sleepy", "alive", "firm", "hard", "light", "affectionate", "compassionate", "soft", "close", "loving", "sexy", "tender", "seductive", "warm", "open", "appealing", "aggressive", "passionate", "hot", "horny", "humbled", "torn", "envious", "jealous", "preoccupied", "cruel", "distant", "bored", "hypocritical", "phony", "cooperative", "burdened", "hopeful", "afraid", "fearful", "frightened", "timid", "wishy-washy", "shaken", "apprehensive", "fidgety", "terrified", "panicky", "tragic", "comedic", "hysterical", "alarmed", "cautious", "shocked", "horrified", "insecure", "impatient", "nervous", "dependent", "anxious", "pressured", "worried", "awed", "dismayed", "scared", "cowardly", "threatened", "appalled", "petrified", "gutless", "edgy"]
feely_tweets = []
i = 0

puts Time.now

@streaming_client.filter(track: topics.join(",")) do |tweet|
  begin
    if tweet.lang == 'en'
      i += 1
      print i
        feely_tweets << {user: tweet.attrs[:user][:screen_name], tweet: tweet.text}
      # puts "#{i} tweets gathered"
      # puts "#{tweet.attrs[:user][:screen_name]} tweeted about feelings: #{tweet.text}"
    end
  rescue JSON::ParserError
    next
  end
  break if i > 10_000
end

Time.now

words = feely_tweets.map { |tweet_datum| tweet_datum[:tweet].split(' ') }.flatten!

sentiment = Hash.new(0)
words.each { |word| sentiment[word.to_sym] += 1 if topics.include? word }

sentiment.each { |word, frequency| print "#{word}: #{frequency}\n" }

puts Time.now