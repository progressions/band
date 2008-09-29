class AddSettingIdToPromo < ActiveRecord::Migration
  def self.up
    add_column :promos, :setting_id, :integer
  end

  def self.down
    remove_column :promos, :setting_id
  end
end
