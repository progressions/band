class AddFooterToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :header, :text
    add_column :settings, :footer, :text
  end

  def self.down
    remove_column :settings, :footer
    remove_column :settings, :header
  end
end
