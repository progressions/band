class AddSubscribeToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :subscribe, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :subscribe
  end
end
