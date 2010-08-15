require 'factory_girl'

# collection of factory helper methods
module FactoryHelper
  # used to create a factory and use block to do any stubbing required
  def create_factory(symbol, params = {})
    factory = Factory.build(symbol, params)
    yield(factory)
    factory.save!

    factory
  end
end

Factory.sequence :name do |num|
  "name#{num}"
end

Factory.sequence :email do |num|
  "name#{num}@example.com"
end


Factory.define :blog do |f|
  f.association             :user
  f.title                   "Too many dicks on the dancefloor"
  f.body                    "There are just too many dicks on the dancefloor. Peace out."
  f.posted_at               Time.now
end


Factory.define :fan do |f|
  f.email             { Factory.next(:email) }
  f.zipcode           "78723"
end

Factory.define :setting do |f|
  f.site_name         "World Racketeering Squad"
  f.artist_name       "World Racketeering Squad"
  f.artist_description "Nerdwave Rock and Roll - \"Like Devo jamming with the Rolling Stones on the Millennium Falcon\""
  f.association       :style
  f.url               "http://www.weracketeer.com"
  f.mail_tag          "WRS"
  f.admin_email       "admin@weracketeer.com"
  f.email             "wrs@weracketeer.com"
  f.facebook_profile  "http://www.facebook.com/weracketeeer"
  f.twitter_profile   "worldracketeer"
  f.free_download     true
  f.free_download_name  "Electromagnetic Pulse"
  f.free_download_filename "03-Electromagnetic-Pulse.mp3"
end

Factory.define :style do |f|
  f.title             "Default"
end

Factory.define :user do |f|
  f.email                   { Factory.next(:email) }
  f.password                "password"
  f.password_confirmation   "password"
end

Factory.define :show do |f|
  f.title                   "WRS at Rockin Tomato"
  f.date                    "September 18, 2010"
  f.time                    "9:00 PM"
  f.association             :venue
end

Factory.define :venue do |f|
  f.name                    "Rockin Tomato"
end