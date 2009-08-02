class TwitterWorker
  def self.check_for_show_notes
    begin
      tweets = user_timeline(global_settings.twitter_profile).reverse
      tweets.each do |tweet|
        begin
          last_tweeted = Time.parse(tweet["created_at"])
          
          if tweet.text =~ /#shownote/
            tweet_date = Time.parse(tweet["created_at"])
            last_checked = global_settings.last_checked_for_show_notes || 1.year.ago
            if last_checked < tweet_date
              show = Show.most_recent.reload
              
              show_notes = show.notes
              show_notes = "#{show_notes}\n#{tweet['text']}"
              
              show.update_attribute(:notes, show_notes)
              puts show_notes
            end
          end
        rescue
        end
      end
      
      global_settings.update_attribute(:last_checked_for_show_notes, Time.now)
      puts global_settings.last_checked_for_show_notes.inspect
    rescue StandardError => e
    end
  end
  
  def self.scan_and_retweet
    if global_settings.scan_and_retweet?
      begin
        Member.active.twitter_enabled.each do |member|
          tweets = user_timeline(member.twitter_username).reverse
    
          tweets.last(global_settings.retweet_count).each do |tweet|
            begin
              last_tweeted = Time.parse(tweet["created_at"])
    
              if member.last_tweeted.nil? || last_tweeted > member.last_tweeted
                text = tweet["text"]
                if global_settings.retweet_replies? || text !~ /^\@/
                  post_update(member, text)
                  member.update_attribute(:last_tweeted, last_tweeted)
                end
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
  
  def self.user_timeline(username)
    url = user_timeline_url(username)
    HTTParty.get(url)
  end
  
  def self.user_timeline_url(username)
    "http://twitter.com/statuses/user_timeline.json?screen_name=#{username}"
  end

  def self.post_update(member, text)
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

  def self.twitter
    username = global_settings.twitter_profile
    password = global_settings.twitter_password
  
    httpauth = Twitter::HTTPAuth.new(username, password)
    Twitter::Base.new(httpauth)
  end

  def self.global_settings
    @global_settings ||= Setting.find(1)
  end  
end