class AddYoutubeFieldsToProfile < ActiveRecord::Migration
  def self.up
    add_column :settings, :video_format, :integer
    add_column :settings, :twitter_profile, :string
  end

  def self.down
    remove_column :settings, :video_format
    remove_column :settings, :twitter_profile
  end
end
