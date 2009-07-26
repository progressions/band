class AddSongHostIdToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :song_host_id, :integer
  end

  def self.down
    remove_column :settings, :song_host_id
  end
end
