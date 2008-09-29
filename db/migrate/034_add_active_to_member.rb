class AddActiveToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :active, :boolean, :default => true
  end

  def self.down
    remove_column :members, :active
  end
end
