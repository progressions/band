class AddSettingIdToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :setting_id, :integer
  end

  def self.down
    remove_column :songs, :setting_id
  end
end
