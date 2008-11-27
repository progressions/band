require 'vendor/gems/twitter-0.3.7/lib/twitter'

print "username: "
get username
print "password: "
get password

	Twitter::Base.new(username, password).update('trying stuff out.')
	
		puts "Public Timeline", "=" * 50
	Twitter::Base.new(username, password).timeline(:friends).each do |s|
	  puts s.text, s.user.name
	  puts
	end