class AddColorIdToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :color_id, :integer
  end

  def self.down
    add_column :colors, :setting_id, :integer
    remove_column :settings, :color_id
  end
end
