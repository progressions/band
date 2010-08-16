class AddFanIdToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :fan_id, :integer
  end

  def self.down
    remove_column :downloads, :fan_id
  end
end
