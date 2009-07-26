require 'vendor/gems/twitter-0.6.12/lib/twitter'

# print "username: "
# get username
# print "password: "
# get password

httpauth = Twitter::HTTPAuth.new(username, password)
base = Twitter::Base.new(httpauth)

puts base.user_timeline
# puts base.verify_credentials