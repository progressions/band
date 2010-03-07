class AddActiveToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :active, :boolean
  end

  def self.down
    remove_column :blogs, :active
  end
end
