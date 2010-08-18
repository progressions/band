class AddThumbnailToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :thumbnail, :string
  end

  def self.down
    remove_column :shows, :thumbnail
  end
end
