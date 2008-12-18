class AddNotesToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :notes, :text
  end

  def self.down
    remove_column :shows, :notes
  end
end
