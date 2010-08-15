Then %r{^print out the email$} do
  Then "print out the email as \"digest\""
end

Then %r{^print out the email as "([^"]*?)"$} do |filename|
  timestamp = Time.now.to_i
  path = "#{Rails.root}/tmp/#{filename}_#{timestamp}.html"
  if ENV["PRINT_EMAIL"]
    body = current_email.body
    File.open(path, "w") do |f|
      f.write(body)
    end
    system "open #{path}"
  else
    puts "\nEmail not printed. Invoke cucumber with PRINT_EMAIL=true to really open the email in a browser.\n" if ENV["VERBOSE"]
  end
end

Then %r{send me the email} do
  Then "send the email to \"progressions@gmail.com\""
end

Then %r{send the email to "([^"]*?)"} do |emails|
  if ENV["SEND_EMAIL"]
    body = current_email.decoded
    mail = current_email
    sender = "progressions@gmail.com"
    destinations = emails.split(",")
  
    smtp_settings = YAML.load_file("#{Rails.root}/config/smtp_credentials.yml")
    smtp = Net::SMTP.new(smtp_settings[:address], smtp_settings[:port])
    smtp.enable_starttls_auto if smtp.respond_to?(:enable_starttls_auto)
    # smtp.enable_tls
    smtp.start(smtp_settings[:domain], smtp_settings[:user_name], smtp_settings[:password],
               smtp_settings[:authentication]) do |smtp|
      smtp.sendmail(mail.encoded, sender, destinations)
    end
    puts "Sent email to #{emails}."
  else
    puts "\nEmail not sent. Invoke cucumber with SEND_EMAIL=true to really send email through SMTP.\n" if ENV["VERBOSE"]
  end
end
