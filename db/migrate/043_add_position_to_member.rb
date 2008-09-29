class AddPositionToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :position, :integer
  end

  def self.down
    remove_column :members, :position
  end
end
