class AddFilenameToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :title, :string
    add_column :songs, :body, :text
    add_column :songs, :filename, :string
    remove_column :songs, :name
  end

  def self.down
    remove_column :songs, :title
    remove_column :songs, :body
    remove_column :songs, :filename
    remove_column :songs, :title
    remove_column :songs, :body
    add_column :songs, :name, :string
  end
end
