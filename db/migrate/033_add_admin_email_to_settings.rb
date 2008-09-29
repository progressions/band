class AddAdminEmailToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :admin_email, :string
    add_column :settings, :site_url, :string
  end

  def self.down
    remove_column :settings, :admin_email
    remove_column :settings, :site_url
  end
end
