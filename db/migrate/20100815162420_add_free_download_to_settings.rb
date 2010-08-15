class AddFreeDownloadToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :free_download, :boolean
    add_column :settings, :free_download_filename, :string
    add_column :settings, :free_download_name, :string
  end

  def self.down
    remove_column :settings, :free_download
    remove_column :settings, :free_download_name
    remove_column :settings, :free_download_filename
  end
end
