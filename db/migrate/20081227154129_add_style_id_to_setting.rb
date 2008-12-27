class AddStyleIdToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :style_id, :integer
  end

  def self.down
    remove_column :settings, :style_id
  end
end
