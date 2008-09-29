class AddLyricsToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :show_lyrics, :boolean
  end

  def self.down
    remove_column :settings, :show_lyrics
  end
end
