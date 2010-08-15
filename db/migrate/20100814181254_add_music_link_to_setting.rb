class AddMusicLinkToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :music_link, :string
  end

  def self.down
    remove_column :settings, :music_link
  end
end
