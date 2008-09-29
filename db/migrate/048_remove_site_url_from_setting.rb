class RemoveSiteUrlFromSetting < ActiveRecord::Migration
  def self.up
    remove_column :settings, :site_url
  end

  def self.down
    add_column :settings, :site_url, :string
  end
end
