class AddCreatedByToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :created_by, :integer
  end

  def self.down
    remove_column :blogs, :created_by
  end
end
