class AddPlaylistToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :featured_playlist, :string
    add_column :settings, :latest_playlist, :string
    add_column :settings, :show_featured_video, :boolean, :default => true
    remove_column :settings, :show_lyrics
    remove_column :settings, :show_promo
    add_column :settings, :show_lyrics, :boolean, :default => true
    add_column :settings, :show_promo, :boolean, :default => true
  end

  def self.down
    remove_column :settings, :featured_playlist    
    remove_column :settings, :latest_playlist
    remove_column :settings, :show_featured_video
  end
end
