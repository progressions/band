class AddEmailToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :email, :string
  end

  def self.down
    remove_column :downloads, :email
  end
end
