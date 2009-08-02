namespace :mailer do
  desc "Deliver periodical status report"
  task :status_report => :environment do
    Mailer.deliver_status_report
  end
  
  desc "Send a test email"
  task :send => :environment do
    ENV["RAILS_ENV"] = "production"
    RAILS_ENV = "production"
    Mailer.send(:deliver_mail, Fan.find_by_zipcode(1138), Mail.first)
  end  
  
  desc "Send a test email through delayed_job"
  task :send_later => :environment do
    ENV["RAILS_ENV"] = "production"
    Mailer.send_later(:deliver_mail, Fan.find_by_zipcode(1138), Mail.first)
  end
end