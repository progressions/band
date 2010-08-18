class AddThumbnailToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :thumbnail, :string
  end

  def self.down
    remove_column :songs, :thumbnail
  end
end
