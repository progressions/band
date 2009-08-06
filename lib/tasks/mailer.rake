namespace :mailer do
  desc "Deliver periodical status report"
  task :status_report => :environment do
    StatusReportWorker.send_status_report
  end
  
  desc "Test status report"
  task :test_status_report => :environment do
    report = StatusReportWorker.send_status_report
    
    body = report.body
    body.gsub!("\\n", "\n")
    body.gsub!("\\t", "\n")
    body.gsub!("\\\"", "\"")
    
    File.open("#{RAILS_ROOT}/digest.html", "w") do |f|
      f.write(body)
    end
    system "open #{RAILS_ROOT}/digest.html"    
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