class AddUrlToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :url, :string
  end

  def self.down
    remove_column :settings, :url
  end
end
