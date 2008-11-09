require File.dirname(__FILE__) + '/../test_helper'

class YoutubeTest < Test::Rails::TestCase
  def test_should_get_user_feed
    wrs = new_user(:id => "worldracketeer")
    assert_not_nil wrs
    assert_equal "worldracketeer", wrs.author
    assert wrs.length > 100
  end
  
  def _test_should_get_users_playlists
    wrs = new_user(:id => "worldracketeer")
    assert_not_nil wrs
    assert_equal "worldracketeer", wrs.author
    assert wrs.length > 100
    playlists = wrs.playlists
    assert_not_nil playlists
    assert playlists.length > 10
  end
  
  def _test_should_get_users_playlist_titles
    wrs = new_user(:id => "worldracketeer")
    assert_not_nil wrs
    assert_equal "worldracketeer", wrs.author
    assert wrs.length > 100
    playlists = wrs.playlists
    assert_not_nil playlists
    assert playlists.length > 10
    assert false, playlists.first.title
    titles = playlists.collect {|p| p.title}
    assert_not_nil titles
    assert titles.length > 10
  end
  
  def test_should_not_get_user_feed
    wrs = new_user(:id => "worldracketeeringsquad") # id is too long
    assert_not_nil wrs
    assert_equal "worldracketeeringsquad", wrs.author
    assert_equal 0, wrs.length
  end

  # http://gdata.youtube.com/feeds/api/videos/03YbknYlJK0
  def _test_should_get_video
    id = "03YbknYlJK0"
    video = new_video(:id => id)
    assert_not_nil video
    assert_equal id, video.video_id    
    assert_equal 'Live from the Rock-It - "Sea Breeze"', video.title
    assert_equal 'double929', video.user.name
    assert_equal video.user.full_name, video.user.name
    assert_equal 'http://gdata.youtube.com/feeds/api/users/double929', video.user.email
    assert_equal "Thu Nov 16 14:47:40 -0600 2006", video.created_at.to_s
    assert_match /object/, video.body
    assert_match /03YbknYlJK0/, video.body
    assert_equal "http://www.youtube.com/v/#{id}", video.url
    assert_equal "http://www.youtube.com/watch?v=#{id}", video.link
  end
  
  def test_should_get_video
    video = new_video(:id => sample_video[:id])
    compare_video(video, sample_video)
  end
  
  # http://www.youtube.com/view_play_list?p=838EB0386BC516DE
  def test_should_get_playlist
    playlist = new_playlist(:id => "838EB0386BC516DE")
    assert_not_nil playlist
    assert playlist.length > 10
  end
  
  def test_should_get_playlist_and_first_video
    playlist = new_playlist(:id => "9626B408C89F94BD")    
    compare_video_collection(playlist,
    {
      :id => "a4pfw7V1pM0",
      :title => "Can't keep track (1 of 5) Green Muse 11/29/2007",
      :user_name => "worldracketeer",
      :email => "http://gdata.youtube.com/feeds/api/users/worldracketeer",
      :date => "2007-12-02T08:35:28.000-08:00"
    })
  end
  
  # http://www.youtube.com/view_play_list?p=838EB0386BC516DE
  def test_should_get_playlist_max_results
    playlist = new_playlist(:id => "838EB0386BC516DE", :max_results => 5)
    assert_not_nil playlist
    assert playlist.length > 10
    assert_equal 5, playlist.videos.length
  end
  
  def test_should_get_top_rated
    videos = YouTube::TopRated.new()
    assert_not_nil videos
    assert_equal "Top Rated", videos.title
  end
  
  def test_should_get_top_favorites
    videos = YouTube::TopFavorites.new()
    assert_not_nil videos
    assert_equal "Top Favorites", videos.title
  end
  
  def test_should_get_most_viewed
    videos = YouTube::MostViewed.new()
    assert_not_nil videos
    assert_equal "Most Viewed", videos.title
  end
  
  def test_should_get_most_discussed
    videos = YouTube::MostDiscussed.new()
    assert_not_nil videos
    assert_equal "Most Discussed", videos.title
  end
  
  def test_should_get_most_linked
    videos = YouTube::MostLinked.new()
    assert_not_nil videos
    assert_equal "Most Linked", videos.title
  end
  
  def test_should_get_most_responded
    videos = YouTube::MostResponded.new()
    assert_not_nil videos
    assert_equal "Most Responded", videos.title
  end
  
  def test_should_get_recently_featured
    videos = YouTube::RecentlyFeatured.new()
    assert_not_nil videos
    assert_equal "Recently Featured", videos.title
  end
 
  def test_should_get_watch_on_mobile
    videos = YouTube::WatchOnMobile.new()
    assert_not_nil videos
    assert_equal "YouTube Mobile Videos", videos.title
  end  

  
  protected
  
  def new_video options
    YouTube::Video.new(options)
  end
  
  def new_user options
    YouTube::User.new(options)
  end
  
  def new_playlist options
    YouTube::Playlist.new(options)
  end
  
  # http://gdata.youtube.com/feeds/api/videos/03YbknYlJK0
  def sample_video options={}
    {:id => "03YbknYlJK0",
     :title => 'Live from the Rock-It - "Sea Breeze"',
     :user_name => "double929",
     :email => "http://gdata.youtube.com/feeds/api/users/double929",
     :date => "Thu Nov 16 14:47:40 -0600 2006"
    }.merge(options)
  end
  
  def compare_video video, options
    assert_not_nil video
    #assert_equal options[:id], video.video_id
    assert_equal options[:title], video.title
    assert_equal options[:user_name], video.user.name
    assert_equal video.user.full_name, video.user.name
    assert_equal options[:email], video.user.email
    # assert_equal options[:date], video.created_at.to_s
    assert_match /object/, video.body
    
    assert_match /^http:\/\/www.youtube.com\/v\/#{options[:id]}/, video.url
    assert_equal "http://www.youtube.com/watch?v=#{options[:id]}", video.link
  end
  
  def compare_video_collection video_collection, options
    assert_not_nil video_collection
    assert_equal 5, video_collection.length
    first_video = video_collection.videos.first
    assert_not_nil first_video
    # assert false, playlist.videos.first.title
    compare_video(first_video, options)
  end
  
end

