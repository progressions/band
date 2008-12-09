class AddMailFooterToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :mail_footer, :text
    add_column :settings, :mail_header, :text
  end

  def self.down
    remove_column :settings, :mail_header
    remove_column :settings, :mail_footer
  end
end
