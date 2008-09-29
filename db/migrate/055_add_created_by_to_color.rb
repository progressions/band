class AddCreatedByToColor < ActiveRecord::Migration
  def self.up
    add_column :colors, :created_by, :integer
  end

  def self.down
    remove_column :colors, :created_by
  end
end
