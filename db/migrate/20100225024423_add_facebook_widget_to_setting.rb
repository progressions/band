class AddFacebookWidgetToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :facebook_widget, :text
  end

  def self.down
    remove_column :settings, :facebook_widget
  end
end
