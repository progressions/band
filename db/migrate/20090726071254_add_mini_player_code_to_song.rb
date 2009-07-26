class AddMiniPlayerCodeToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :mini_player_code, :text
  end

  def self.down
    remove_column :songs, :mini_player_code
  end
end
