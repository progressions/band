class AddSongsHostToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :songs_host, :string
    add_column :settings, :on_the_web, :text
  end

  def self.down
    remove_column :settings, :songs_host
    remove_column :settings, :on_the_web
  end
end
