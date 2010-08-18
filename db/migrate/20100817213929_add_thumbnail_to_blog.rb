class AddThumbnailToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :thumbnail, :string
  end

  def self.down
    remove_column :blogs, :thumbnail
  end
end
