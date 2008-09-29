class RemoveSubscribeFromComment < ActiveRecord::Migration
  def self.up
    remove_column :comments, :subscribe
  end

  def self.down
    add_column :comments, :subscribe, :boolean, :default => false
  end
end
