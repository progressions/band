require 'lib/youtube'

=begin
puts "TopRated: " + YouTube::TopRated.new.videos[0].title
puts "TopFavorites: " + YouTube::TopFavorites.new.videos[0].title
puts "MostViewed: " + YouTube::MostViewed.new.videos[0].title
puts "MostDiscussed: " + YouTube::MostDiscussed.new.videos[0].title
puts "MostLinked: " + YouTube::MostLinked.new.videos[0].title
puts "MostResponded: " + YouTube::MostResponded.new.videos[0].title
puts "RecentlyFeatured: " + YouTube::RecentlyFeatured.new.videos[0].title
puts "WatchOnMobile: " + YouTube::WatchOnMobile.new.videos[0].title

puts
puts
=end




wrs = YouTube::User.new(:id => "worldracketeer")
puts "PLAYLISTS:"
puts wrs.playlists




# puts d.inspect
# puts d.class
# puts d.elements.inspect










# puts wrs.url
# puts wrs.length
# puts wrs.videos.length
# 
# puts wrs.playlists
# pd = wrs.playlists_doc
# p = REXML::Document.new(pd)
# puts p.inspect

# puts wrs.doc

=begin
puts wrs.videos.length
puts wrs.videos[0].title
wrs_faves = wrs.favorites
puts wrs_faves.length
puts wrs_faves.videos[0].title

other_wrs_faves = YouTube::Favorites.new(:id => "worldracketeer", :start_index => 5, :max_results => 15)
puts other_wrs_faves.length
puts other_wrs_faves.videos.length
puts other_wrs_faves.videos[0].title

demonstrations = YouTube::Playlist.new(:id => "838EB0386BC516DE")

puts demonstrations.url
puts demonstrations.link
puts demonstrations.title
puts demonstrations.updated
puts demonstrations.videos.length
latest_demo = demonstrations.videos[0]
puts latest_demo.title
puts latest_demo.id
puts latest_demo.url
puts latest_demo.updated
puts latest_demo.views
puts demonstrations.videos[1].views


puts

wrs = YouTube::User.new(:id => "worldracketeer")

puts wrs.url
puts wrs.link
puts wrs.title
puts wrs.updated
puts wrs.length
puts wrs.author

=end