class TwitterWorker
  def self.scan_and_retweet
    if global_setting.scan_and_retweet?
      begin
        Member.active.twitter_enabled.each do |member|
          @url = "http://twitter.com/statuses/user_timeline.json?screen_name=#{member.twitter_username}"
          tweets = HTTParty.get(@url).reverse
    
          tweets.last(global_settings.scan_tweet_count).each do |tweet|
            begin
              last_tweeted = Time.parse(tweet["created_at"])
    
              if member.last_tweeted.nil? || last_tweeted > member.last_tweeted
                post_update(member, tweet["text"])
                member.update_attribute(:last_tweeted, last_tweeted)
              end
            rescue StandardError => e
            end
          end
        end
      rescue StandardError => e
        # logger.info("There was an error connecting to Twitter. #{e.inspect}")
      end
    end
  end

  protected

  def post_update(member, text)
    if global_settings.retweet_replies? || text !~ /^\@/
      if member.twitter_tag.blank?
        update = text
      else
        update = "[#{member.twitter_tag}] #{text}"
      end
      if Rails.env.production?
        twitter.update(update)
      else
        puts update
      end
    end
  end

  def twitter
    username = global_settings.twitter_profile
    password = global_settings.twitter_password
  
    httpauth = Twitter::HTTPAuth.new(username, password)
    Twitter::Base.new(httpauth)
  end

  def global_settings
    @global_settings ||= Setting.find(1)
  end  
end