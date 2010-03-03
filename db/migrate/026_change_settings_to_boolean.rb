class ChangeSettingsToBoolean < ActiveRecord::Migration
  def self.up
    remove_column :settings, :show_blog
    remove_column :settings, :show_news
    remove_column :settings, :show_music
    remove_column :settings, :show_videos
    remove_column :settings, :show_shows
    remove_column :settings, :show_fans
    
    add_column :settings, :show_blog, :boolean, :default => true
    add_column :settings, :show_news, :boolean, :default => true
    add_column :settings, :show_music, :boolean, :default => true
    add_column :settings, :show_videos, :boolean, :default => true
    add_column :settings, :show_shows, :boolean, :default => true
    add_column :settings, :show_fans, :boolean, :default => true
  end

  def self.down
    remove_column :settings, :show_blog
    remove_column :settings, :show_news
    remove_column :settings, :show_music
    remove_column :settings, :show_videos
    remove_column :settings, :show_shows
    remove_column :settings, :show_fans
    
    add_column :settings, :show_blog, :integer, :default => true
    add_column :settings, :show_news, :integer, :default => true
    add_column :settings, :show_music, :integer, :default => true
    add_column :settings, :show_videos, :integer, :default => true
    add_column :settings, :show_shows, :integer, :default => true
    add_column :settings, :show_fans, :integer, :default => true  
  end
end