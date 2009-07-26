class AddPlayerCodeToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :player_code, :text
  end

  def self.down
    remove_column :songs, :player_code
  end
end
