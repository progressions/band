class AddCoverToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :cover, :string
  end

  def self.down
    remove_column :shows, :cover
  end
end
