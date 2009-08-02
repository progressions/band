namespace :twitter do
  task :check_for_tweets => :environment do
    TwitterWorker.scan_and_retweet
  end
  
  task :check_for_show_notes => :environment do
    TwitterWorker.check_for_show_notes
  end
end