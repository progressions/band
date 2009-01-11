class AddActiveToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :active, :boolean, :default => true
  end

  def self.down
    remove_column :shows, :active
  end
end
