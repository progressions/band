class ChangeShowBodyToText < ActiveRecord::Migration
  def self.up
    remove_column :shows, :body
    add_column :shows, :body, :text
  end

  def self.down
    remove_column :shows, :body
    add_column :shows, :body, :string
  end
end
