class AddSettingIdToColor < ActiveRecord::Migration
  def self.up
    add_column :colors, :setting_id, :integer
  end

  def self.down
    remove_column :colors, :setting_id
  end
end
