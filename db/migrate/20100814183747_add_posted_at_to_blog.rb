class AddPostedAtToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :posted_at, :datetime
  end

  def self.down
    remove_column :blogs, :posted_at
  end
end
