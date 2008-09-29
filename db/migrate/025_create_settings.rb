class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :site_name
      t.string :artist_name
      t.text :artist_description
      t.integer :show_blog
      t.integer :show_news
      t.integer :show_music
      t.integer :show_videos
      t.integer :show_shows
      t.integer :show_fans

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
