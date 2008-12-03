class AddWebsitesToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :facebook_profile, :string
    add_column :settings, :myspace_profile, :string
  end

  def self.down
    remove_column :settings, :myspace_profile
    remove_column :settings, :facebook_profile
  end
end
