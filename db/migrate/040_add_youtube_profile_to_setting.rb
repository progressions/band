class AddYoutubeProfileToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :youtube_profile, :string
  end

  def self.down
    remove_column :settings, :youtube_profile
  end
end
