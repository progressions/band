require File.dirname(__FILE__) + '/../test_helper'

class SongTest < ActiveSupport::TestCase
  fixtures :songs
  
  def test_invalid_with_empty_attributes
    song = Song.new
    assert !song.valid?
    assert song.errors.invalid?(:title)
  end
  
  def test_invalid_without_title
    song = Song.new(:body => "Hey this is a song")
    assert !song.valid?
    assert song.errors.invalid?(:title)
  end
  
  def test_valid_song    
    song = songs(:one)
    assert song.valid?
  end
  
  def test_delete
    count = Song.count
    song = songs(:one)
    song.destroy
    assert_equal count-1, Song.count
  end
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different song"
    song = songs(:one)
    song.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, song.title
    assert_equal new_body, song.body
  end
  
  def test_create
    count = Song.count
    song = Song.new(:title => "A song", :filename => "song.mp3", :body => "Hey, this is a song")
    assert song.save
    assert_equal count+1, Song.count
  end
  
  def test_read
    assert 2, Song.count
    song = Song.find(1)
    assert_equal songs(:one).title, song.title
    assert_equal songs(:one).body, song.body
  end
  
  def test_filename
    song = Song.find(1)
    assert_match /\....$/, songs(:one).filename
  end
end
