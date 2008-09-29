class AddDescriptionToSong < ActiveRecord::Migration
  def self.up
    # add_column :songs, :description, :text
  end

  def self.down
    # remove_column :songs, :description
  end
end
