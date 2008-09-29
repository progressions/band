class AddMailTagToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :mail_tag, :string
  end

  def self.down
    remove_column :settings, :mail_tag
  end
end
