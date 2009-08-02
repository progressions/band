namespace :twitter do
  task :check_for_tweets => :environment do
    TwitterWorker.scan_and_retweet
  end
end