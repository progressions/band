class ChangeSettingsToBoolean < ActiveRecord::Migration
  def self.up
    remove_column :settings, :show_blog
    remove_column :settings, :show_news
    remove_column :settings, :show_music
    remove_column :settings, :show_videos
    remove_column :settings, :show_shows
    remove_column :settings, :show_fans
    
    add_column :settings, :show_blog, :boolean, :default => 1
    add_column :settings, :show_news, :boolean, :default => 1
    add_column :settings, :show_music, :boolean, :default => 1
    add_column :settings, :show_videos, :boolean, :default => 1
    add_column :settings, :show_shows, :boolean, :default => 1
    add_column :settings, :show_fans, :boolean, :default => 1
  end

  def self.down
    remove_column :settings, :show_blog
    remove_column :settings, :show_news
    remove_column :settings, :show_music
    remove_column :settings, :show_videos
    remove_column :settings, :show_shows
    remove_column :settings, :show_fans
    
    add_column :settings, :show_blog, :integer, :default => 1
    add_column :settings, :show_news, :integer, :default => 1
    add_column :settings, :show_music, :integer, :default => 1
    add_column :settings, :show_videos, :integer, :default => 1
    add_column :settings, :show_shows, :integer, :default => 1
    add_column :settings, :show_fans, :integer, :default => 1  
  end
end